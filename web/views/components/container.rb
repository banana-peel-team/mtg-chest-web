require_relative '../component'

module Web
  module Views
    module Components
      class Container < Component
        def render(html, context)
          html.tag('div', class: 'container') do
            super(html, context)
          end
        end
      end
    end
  end
end
