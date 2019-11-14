module Yugo
  class Response
    attr_reader :site, :env, :page, :headers

    HTTP_404 = <<-HTML
      <h1>404 Not Found</h1>
      <pre><%= env['REQUEST_PATH'] %></pre>
      <ul>
        <% site.pages.keys.each do |page| %>
          <li><a href="<%= page %>"><%= page %></a></li>
        <% end %>
      </ul>
    HTML

    HTTP_505 = <<-HTML
      <h1>505 Server Error</h1>
      <p>Please see server logs for details.</p>
    HTML

    def initialize(site, env)
      @site = site
      @env  = env
      @page = site.pages[env['REQUEST_PATH']]
    end

    def header(page)
      {'Content-Type' => page.content_type}
    end

    def render
      if page.nil?
        page = Page.new(site, StringIO.new(HTTP_404)).render(env)
        ['404', headers, [page.render(env)]]
      else
        ['200', headers, [page.render(env)]]
      end
    end
  end
end
