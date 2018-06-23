module Web
  module Views
    module Extensions
      module Icons
        class Extension
          attr_reader :html

          def initialize(html)
            @html = html
          end

          def icon(name, attrs = {})
            cls = "fas fa-#{name}"
            cls << ' icon-danger' if attrs[:style] == 'danger'

            html.tag('i', class: cls)
          end

          def icon_button(name, title, attrs = {})
            attrs = attrs.dup
            cls = 'btn btn-sm'

            case attrs.delete(:style)
            when 'danger'
              cls << ' btn-outline-danger'
            end

            attrs.merge!(
              class: cls,
              type: 'submit',
              title: title,
            )

            html.tag('button', attrs) do
              icon(name)
            end
          end

          def icon_link(path, name, alt)
            html.append_html(
              %Q(<a href="#{path}" title="#{alt}"><i class="fas fa-#{name}">) +
              %Q(<span class="alt-text">#{alt}</span></i></a>)
            )
          end

          # TODO: ?
          def delete_button
            icon_button('trash-alt', 'Delete', style: 'danger')
          end
        end

        def icons
          @icons ||= Icons::Extension.new(self)
        end
      end
    end
  end
end
