require_relative '../component'

module Web
  module Views
    module Components
      class Navigation < Component
        def render(html, context)
          if options[:breadcrumb]
            html.tag('nav', 'aria-label': 'Breadcrumb') do
              html.tag('ol', class: 'breadcrumb') do
                super(html, context)
              end
            end
          else
            cls = 'navbar navbar-expand navbar-light'
            html.tag('nav', class: cls, 'aria-label': 'Navigation') do
              html.tag('ul', class: 'navbar-nav') do
                super(html, context)
              end
            end
          end
        end
      end
    end
  end
end
