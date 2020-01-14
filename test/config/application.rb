require_relative '../../lib/yugo'

YugoTests = Yugo::Application.new do |app|
  app.logger      = Logger.new(STDERR)
  app.cache_pages = ENV['RACK_ENV'] == 'production'
  app.session_key = ENV.fetch('RAILS_MASTER_KEY')
  app.root_path   = File.join(__dir__, '../pages')
end
