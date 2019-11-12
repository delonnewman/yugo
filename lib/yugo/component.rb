require 'forwardable'

module Yugo
  class Component
    include Forwardable

    # forward scopes to @page
    def_delegator :@page, :server, :variables, :uri, :form

    def initialize(page)
      @page = page
    end
  end
end
