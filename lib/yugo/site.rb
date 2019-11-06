module Yugo
  class Site
    class PageDoesNotExist < Exception; end

    DEFAULT_PAGES_PATH = '/pages'

    attr_reader :pages_path
    attr_reader :pages

    # Provides 'server' scope a struct with various server information
    # (see Yugo::Page#server, and https://cfdocs.org/server-scope)
    attr_reader :server

    def initialize(config = {})
      @config = config
      @server = Yugo::Struct.new
      @pages_path = File.join(Dir.pwd, config.fetch(:pages_path, DEFAULT_PAGES_PATH))
      @pages = Dir["#{@pages_path}/**/*"].entries.reduce({}) do |h, file|
        path = file.gsub(@pages_path, '').gsub(File.extname(file), '')
        h.merge(path => lambda { Page.new(self, path, IO.read(file)) })
      end
    end

    # Rack interface
    def call(env)
      Response.new(self, env).render
    end
  end
end
