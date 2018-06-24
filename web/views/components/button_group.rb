require_relative '../component'

module Web
  module Views
    module Components
      class ButtonGroup < Component
        def render(html, context)
          html.tag('div', class: 'btn-group') do
            super(html, context)
          end
        end
      end
    end
  end
end
