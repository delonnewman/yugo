require 'erb'
require 'json'
require_relative '../lib/yugo'

if ARGV.count < 1
  puts "USAGE: #$0 DIR"
  exit 0
end

DIR = ARGV.first
TEMPLATE = "#{__dir__}/analyze.html.erb"

def tags(code)
  code.lines
    .each_with_index
    .select { |(line, _i)| line =~ /\<cf\w+/i }
    .map { |(line, i)| { matches: line.scan(/\<(cf\w+)/i).map(&:first), line: i + 1 } }
end

def functions(code)
  code.lines
    .each_with_index
    .select { |(line, _i)| line =~ /\w+\(/ }
    .map { |(line, i)| { matches: line.scan(/([\.\w]+)\(/).map(&:first), line: i + 1 } }
end

def file_analysis(file)
  code = IO.read(file)
  { file: file,
    functions: functions(code),
    tags: tags(code) }
end

def totals(files, attr)
  files.flat_map { |file| file[attr].flat_map { |item| item[:matches] } }.map(&:downcase).uniq.sort
end

def analysis(dir)
  files = Dir["#{dir}/**/*.{cfm,cfml,cfc}"]
    .map { |rel| File.expand_path(File.join(dir, rel)) }
    .map { |file| file_analysis(file) }
  { totals: {
      tags: totals(files, :tags),
      functions: totals(files, :functions)
    },
    dir: dir,
    files: files
  }
end

def title(dir)
  File.basename(dir).split('_').map(&:capitalize).join(' ')
end

def report(dir)
  data = analysis(dir)
  title = title(dir)
  ERB.new(IO.read(TEMPLATE)).result(binding)
end

#print report(DIR)
pp analysis(DIR)
