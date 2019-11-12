module Yugo
  class Page
    include Runtime

    CONTENT_TYPES = {
      erb:  'text/html',
      cfm:  'text/html',
      html: 'text/html',
      htm:  'text/html',
      png:  'image/png',
      jpg:  'image/jpeg',
      jpeg: 'image/jpeg',
      gif:  'image/gif',
      pdf:  'application/pdf',
      csv:  'text/csv'
    }.freeze

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
    }

    attr_reader :site, :request_path, :content, :content_type, :file_type, :logger

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

    def initialize(site, request_path, io, file_type)
      @site = site
      @request_path = request_path
      @io = io
      @variables = Yugo::Struct.new
      @server = @site.server
      @logger = Logger.new(STDERR)
      @file_type = file_type
      @content_type = CONTENT_TYPES.fetch(@file_type, 'text/plain')
    end

    def defined?(var_name)
      not @variables[var_name].nil?
    end

    def content
      @content ||= @io.read
    end

    def render(env)
      # populate cgi, url, and form scopes
      @cgi  = _cgi_variables(env)
      @url  = _url_variables(env)
      @form = _form_variables(env)
      case file_type
      when :erb
        ::ERB.new(content).result(binding)
      when :cfm, :cfc
        evaluate(content)
      else
        content
      end
    end

    def evaluate(str)
      ::ERB.new(Yugo::CFML.compile_string(str)).result(binding)
    end

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
          [_uri_decode(key), _uri_decode(value)]
        end
        Yugo::Struct[pairs]
      end

      def _uri_decode(str)
        URI.decode(str.gsub('+', ' '))
      end
  end
end
