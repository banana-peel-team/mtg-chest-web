require_relative '../component'

module Web
  module Views
    module Components
      class NavigationItem < Component
        def render(html, context)
          render_item(html, context)
        end

        private

        def item_values(context)
          [
            options[:label],
            options[:url]
          ]
        end

        def render_item(html, context)
          label, url = item_values(context)

          current = options[:current] || !url

          cls =
            if options[:breadcrumb]
              'breadcrumb-item'
            else
              'nav-item'
            end

          cls << ' active' if current

          if current
            html.tag('li', label, class: cls)
          else
            html.tag('li', class: cls) do
              cls =
                unless options[:breadcrumb]
                  'nav-link'
                end

              html.link(url, label, class: cls)
            end
          end
        end
      end
    end
  end
end
