require_relative '../component'

module Web
  module Views
    module Components
      class Row < Component
        def render(html, context)
          html.tag('div', class: 'row') do
            html.tag('div', class: 'col-12') do
              super(html, context)
            end
          end
        end
      end
    end
  end
end
