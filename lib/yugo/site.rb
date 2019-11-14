module Yugo
  class Site
    DEFAULT_PAGES_PATH = '/pages'.freeze

    REQUEST_PATH = 'REQUEST_PATH'.freeze
    CONTENT_TYPE = 'Content-Type'.freeze
    ERB          = 'erb'.freeze

    HTTP_404 = <<-HTML.freeze
      <html>
      <head>
        <title>Page Not Found</title>
      </head>
      <body>
        <h1>Page Not Found</h1>
        <p>Here are some valid options:</p>
        <ul>
          <% site.pages.keys.each do |page| %>
            <li><a href="<%= page %>"><%= page %></a></li>
          <% end %>
        </ul>
      </body>
      </html>
    HTML

    # Configuration options
    attr_accessor :pages_path, :root_path, :cache_pages, :session_key, :logger

    # Provides 'server' scope a struct with various server information
    # (see Yugo::Page#server, and https://cfdocs.org/server-scope)
    attr_reader :server

    def initialize(app = nil, config = {})
      @app = app # TODO: make a Yugo Site compose with other rack middleware (e.g. Rails)
      @server = Yugo::Struct.new

      # set config defaults
      @root_path   = config.fetch(:root_path, Dir.pwd)
      @pages_path  = config.fetch(:pages_path, File.join(@root_path, DEFAULT_PAGES_PATH))
      @cache_pages = config.fetch(:cache_pages, ENV['RACK_ENV'] == 'production')
      @logger      = config.fetch(:logger, Logger.new(STDERR))
      @middleware  = {}

      yield self if block_given?

      # load default middleware
      use Rack::CommonLogger, logger
      use Rack::ShowExceptions
      use Rack::Session::Cookie, key: session_key
      # TODO: look into Rack::Static for serving static files
    end

    def pages
      return @pages if cache_pages? && @pages 

      @pages = Dir["#{@pages_path}/**/*"].entries.reduce({}) do |h, file|
        path = file.gsub(@pages_path, '')
        path.gsub!(File.extname(file), '') if file.end_with?(ERB)
        h.merge!(path.downcase.to_sym => Page.new(self, file))
      end

      unless @pages.key?(:'/404')
        @pages[:'/404'] = Page.new(self, StringIO.new(HTTP_404), file_type: :erb)
      end

      @pages
    end

    def use(klass, *args)
      @middleware[klass] = args unless @middleware.key?(klass)
      self
    end

    # compose middleware and return resulting app
    def rack_app
      @middleware.reduce(self) do |app, (klass, args)|
        klass.new(app, *args)
      end
    end

    def cache_pages?
      !!@cache_pages
    end

    def header(page)
      {CONTENT_TYPE => page.content_type}
    end

    # Rack interface
    def call(env)
      page = pages[env[REQUEST_PATH].downcase.to_sym]
      if page.nil? && @app
        @app.call(env)
      elsif page.nil?
        page = pages[:'/404']
        Rack::Response.new(page.render(env), 404, header(page))
      else
        Rack::Response.new(page.render(env), 200, header(page))
      end
    end
  end
end
