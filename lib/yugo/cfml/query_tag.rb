module Yugo
  module CFML
    class QueryParamTag < Node
      def ruby_ast(scope)
        attrs = Yugo::Utils.attribute_list(attribute_list, scope)
        value = attrs.fetch(:value)
        params = scope.variables.fetch(:params, [])
        scope.add_variable(:params, params + [value])
        Yugo::ERB::Text.new('?')
      end
    end

    class QueryTag < Node
      ATTR_ERROR = 'Must specify datasource or dbtype, but not both.'.freeze

      def ruby_ast(scope)
        attrs = Yugo::Utils.attribute_list(open_query_tag.attribute_list, scope)
        ds = attrs[:datasource]
        type = attrs[:dbtype]
        name = attrs[:name]
        scope_ = scope.in_query_scope

        raise ATTR_ERROR if ds.nil? and type.nil?
        raise ATTR_ERROR if !ds.nil? and !type.nil?

        query = query_tag_content.ruby_ast(scope_)
        params = scope_.variables.fetch(:params, [])

        ast = Yugo::Ruby::Index.new(
                Yugo::Ruby::Index.new(
                  Yugo::Ruby::BlockVariable.new(Yugo::Ruby::Identifier.from(:db)), [ds.as_syntax_symbol]),
                [query] + params)

        ast = if name.nil?
                # generate method call e.g. DB[QUERY]
                ast
              else
                # TODO: generate module function and heredoc const with SQL
                # e.g.
                # SELECT_TEST =<<-SQL
                #   select * from test;
                # SQL
                #
                # def self.select_test
                #   DB[SELECT_TEST]
                # end
                Yugo::Ruby::Assignment.new(name.as_instance_variable, ast)
              end

        Yugo::ERB::StatementTag.new(ast)
      end
    end
  end
end
