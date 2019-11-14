require_relative '../../lib/yugo'

Site = Yugo::Site.new do |site|
  site.logger      = Logger.new(STDERR)
  site.cache_pages = ENV['RACK_ENV'] == 'production'
  site.session_key = ENV.fetch('RAILS_MASTER_KEY')
  site.root_path   = File.join(__dir__, '../pages')
end
