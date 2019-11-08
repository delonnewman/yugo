module Yugo
  module CFML
    class OutputTag < Node
      def ruby_ast(scope)
        # TODO: need to add attribute processing
        # attrs = Yugo::CFML.parse_attribute_list(open_output_tag.attribute_list)
        output_tag_content.ruby_ast(scope)
      end
    end
  end
end
