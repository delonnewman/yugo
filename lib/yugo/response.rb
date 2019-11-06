module Yugo
  class Response
    attr_reader :site, :env, :page, :headers

    HTTP_404 = <<-HTML
      <h1>404 Not Found</h1>
      <pre><%= env['REQUEST_PATH'] %></pre>
      <ul>
        <% site.pages.keys.each do |page| %>
          <li><%= page %></li>
        <% end %>
      </ul>
    HTML

    HTTP_505 = <<-HTML
      <h1>505 Server Error</h1>
      <p>Please see server logs for details.</p>
    HTML

    def initialize(site, env)
      @site    = site
      @env     = env
      @page    = site.pages[env['REQUEST_PATH']]
      @headers = {'Content-Type' => 'text/html'}
    end

    def render
      if page.nil?
        ['404', headers, [Page.new(site, env['REQUEST_PATH'], HTTP_404).render(env)]]
      else
        begin
          ['200', headers, [page.call.render(env)]]
        rescue => _
          # TODO: add logger
          ['500', headers, HTTP_505]
        end
      end
    end
  end
end
