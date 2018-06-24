require_relative '../component'

module Web
  module Views
    module Components
      class Col < Component
        def render(html, context)
          cls = (width = options[:width]) ? "col-#{width}" : 'col'

          html.tag('div', class: cls) do
            super(html, context)
          end
        end
      end
    end
  end
end
