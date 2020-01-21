module Yugo
  module CFML
    class QueryParamTag < Node
      def ruby_ast(scope)
      end
    end

    class QueryTag < Node
      ATTR_ERROR = 'Must specify datasource or dbtype, but not both.'.freeze

      def ruby_ast(scope)
        attrs = Yugo::Utils.attribute_list(self, scope)
        ds = attrs[:datasource]
        type = attrs[:dbtype]

        raise ATTR_ERROR if ds.nil? and type.nil?
        raise ATTR_ERROR if !ds.nil? and !type.nil?

        
      end
    end
  end
end
