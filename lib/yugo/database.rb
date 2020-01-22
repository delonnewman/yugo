module Yugo
  class Database
    def initialize(app)
      @app = app
    end

    def [](ds)
      @app.db(ds)
    end
  end
end
