require 'erb'
require 'json'
require 'sequel'
require_relative '../lib/yugo'

if ARGV.count < 1
  puts "USAGE: #$0 DIR"
  exit 0
end

DIR = ARGV.first
DB = Sequel.jdbc("jdbc:sqlite://#{__dir__}/../examples/db/insight.sqlite3")

TAG_TYPE = 'tag'
FUNCTION_TYPE = 'function'

DB.create_table?(:occurances) do
  primary_key :id
  String  :app, null: false, index: true
  String  :file, null: false, index: true
  Integer :line_number, null: false, index: true
  String  :feature, null: false, index: true
  String  :feature_type, null: false, index: true
end

def tags(code)
  code.lines
    .map(&:scrub)
    .each_with_index
    .select { |(line, _i)| line =~ /\<cf\w+/i }
    .map { |(line, i)| [line.scan(/\<(cf\w+)/i).map(&:first), i + 1] }
    .flat_map { |(features, line)| features.map { |f| [f, line] } }
    .map { |(feature, line)| { feature: feature, feature_type: TAG_TYPE, line_number: line } }
end

def functions(code)
  code.lines
    .map(&:scrub)
    .each_with_index
    .select { |(line, _i)| line =~ /\w+\(/ }
    .map { |(line, i)| [line.scan(/([\.\w]+)\(/).map(&:first), i + 1] }
    .flat_map { |(features, line)| features.map { |f| [f, line] } }
    .map { |(feature, line)| { feature: feature, feature_type: FUNCTION_TYPE, line_number: line } }
end

def file_analysis(file)
  code = IO.read(file)
  (functions(code) + tags(code)).map { |x| x.merge(file: file) }
end

def totals(files, attr)
  files.flat_map { |file| file[attr].flat_map { |item| item[:matches] } }.map(&:downcase).uniq.sort
end

def title(dir)
  File.basename(dir).split(/[_\-]/).map(&:capitalize).join(' ')
end

def analysis(dir)
  app = title(dir)
  files = Dir["#{dir}/**/*.{cfm,cfml,cfc}"]
    .map { |rel| File.expand_path(File.join(dir, rel)) }
    .flat_map { |file| file_analysis(file) }
    .map { |x| x.merge(app: app) }
end

occurances = analysis(DIR)
DB.transaction do
  occurances.each do |occurance|
    DB[:occurances].insert(occurance)
  end
end
