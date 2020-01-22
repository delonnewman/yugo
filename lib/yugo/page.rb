module Yugo
  class Page
    include Runtime

    TEMPLATE_TYPES = %w[.erb .cfm .cfml].to_set.freeze
    TEXT_HTML      = 'text/html'.freeze

    CGI_VARIABLES = {
      'SERVER_SOFTWARE'   => 'SERVER_SOFTWARE',
      'SERVER_NAME'       => 'SERVER_NAME',
      'GATEWAY_INTERFACE' => 'GATEWAY_INTERFACE',
      'SERVER_PROTOCOL'   => 'SERVER_PROTOCOL',
      'SERVER_PORT'       => 'SERVER_PORT',
      'REQUEST_METHOD'    => 'REQUEST_METHOD',
      'PATH_INFO'         => 'PATH_INFO',
      'PATH_TRANSLATED'   => 'PATH_INFO',
      'SCRIPT_NAME'       => 'SCRIPT_NAME',
      'QUERY_STRING'      => 'QUERY_STRING',
      'REMOTE_HOST'       => 'HTTP_HOST',
      'REMOTE_ADDR'       => 'REMOTE_ADDR',
      'AUTH_TYPE'         => 'AUTH_TYPE',
      'REMOTE_USER'       => 'REMOTE_USER',
      'AUTH_USER'         => 'AUTH_USER',
      'REMOTE_IDENT'      => 'REMOTE_IDENT',
      'CONTENT_TYPE'      => 'CONTENT_TYPE',
      'CONTENT_LENGTH'    => 'CONTENT_LENGTH'
    }.freeze

    attr_reader :application, :path, :content_type, :file_type, :logger, :request

    # 'Variables' scope, the default scope of 'cfset' for 'page' scoped variables
    attr_reader :variables

    # 'CGI' scope
    attr_reader :cgi

    # 'server' scope
    attr_reader :server

    # 'url' scope
    attr_reader :url

    # 'form' scope
    attr_reader :form

    def initialize(application, path, content_type: nil, file_ext: nil)
      @application = application
      @path = path
      @content_type = content_type
      @file_ext = file_ext
      @variables = Yugo::Struct.new
      @server = @application.server
      @logger = Logger.new(STDERR)
    end

    # TODO: add caching with application configuration
    def content
      return @content if application.cache_pages? && @content

      @content = if file?
                   IO.read(path)
                 elsif io?
                   path.read
                 else
                   path
                 end
    end

    def file?
      path.is_a?(String) && File.exists?(path)
    end

    def io?
      path.respond_to?(:read)
    end

    def file_ext
      @file_ext ||= if file?
                       File.extname(path)
                     end
    end

    def content_type
      @content_type ||= if TEMPLATE_TYPES.include?(file_ext)
                          TEXT_HTML
                        else
                          Rack::Mime.mime_type(file_ext)
                        end
    end

    def render(env)
      # populate cgi, url, and form scopes
      @env     = env
      @request = Rack::Request.new(env)
      @cgi     = _cgi_variables(env)
      @url     = _url_variables(env)
      @form    = _form_variables(env)
      case file_ext.to_sym
      when :'.erb'
        ::ERB.new(content).result(binding)
      when :'.cfm', :'.cfml', :'.cfc'
        evaluate(content)
      else
        content
      end
    end

    def params
      @params ||= if @env
                    _form_variables(@env).merge(_url_variables(@env))
                  else
                    {}
                  end
    end

    def include(file)
      raise "include can only be called from within a page template" if @env.nil?
      logger.info "including: #{file.inspect}"

      @includes ||={}
      return @includes[file] if application.cache_pages? && @includes.key?(file)

      @includes[file] = Page.new(application, File.join(File.dirname(path), file)).render(@env)
    end

    def db
      Yugo::Database.new(@application)
    end

    def evaluate(str)
      begin
        ::ERB.new(Yugo::CFML.compile_string(str)).result(binding)
      rescue => e
        e.message
      end
    end

    # TODO: Move this to examples app
    def format(object, opts = {})
      object.ai(opts.merge(html: true))
    end

    private

      def _cgi_variables(env)
        CGI_VARIABLES.reduce(Yugo::Struct.new) do |h, (k, v)|
          h.merge(k => env[v])
        end
      end

      def _url_variables(env)
        _parse_uri_encoded_content(env.fetch('QUERY_STRING', ''))
      end

      def _form_variables(env)
        _parse_uri_encoded_content(env.fetch('rack.input', StringIO.new).read)
      end

      def _parse_uri_encoded_content(content)
        pairs = content.split('&').map { |x| x.split('=') }.map do |(key, value)|
          [_uri_decode(key).to_sym, _uri_decode(value)]
        end
        Yugo::Struct[pairs]
      end

      def _uri_decode(str)
        URI.decode(str.gsub('+', ' '))
      end
  end
end
