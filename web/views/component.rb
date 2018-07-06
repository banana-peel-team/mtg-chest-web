module Web
  module Views
    #
    # Example:
    #
    #   component = Component.new([
    #     Component.new([Component.new()]),
    #     Component.new(name: 'test'),
    #   ], some_option: true, other: 42)
    #
    #   component.render(html, some_context)
    #
    class Component
      attr_reader :elements, :options

      def initialize(elements = nil, options = {})
        if elements.is_a?(Hash)
          options = elements
          elements = nil
        end

        @options = default_options.merge(options)
        @elements = elements || build_elements
      end

      def render(html, context)
        return unless elements
        render_elements(html, context)
      end

      private

      def default_options
        {}
      end

      def build_elements
        nil
      end

      def render_elements(html, context)
        context = children_context(context)
        elements.each { |element| element.render(html, context) }
      end

      def children_context(context)
        context
      end

      def tag_id(*parts)
        id = parts.reject(&:nil?).join('-')

        fix_tag_id(id)
      end

      def fix_tag_id(id)
        id.gsub(/[\[\]-]+/, '-').chomp('-')
      end

      def child_name(name)
        return name unless options[:name]

        name = name.gsub(/^(\w+)(.*)$/, '[\1]\2')

        "#{options[:name]}#{name}"
      end
    end
  end
end

