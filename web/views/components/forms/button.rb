require_relative 'field'

module Web
  module Views
    module Components
      module Forms
        class Button < Field
          def render(html, context)
            return unless visible?(context)

            icon = options[:icon]

            if icon
              render_icon(html, context)
            else
              render_default(html, context)
            end
          end

          private

          def render_default(html, context)
            cls = 'btn btn-primary'
            cls << ' ' + options[:class] if options[:class]

            attrs = {
              type: 'submit',
              class: cls,
              title: options[:label],
              value: options[:value],
            }

            html.tag('button', attrs)
          end

          def render_icon(html, context)
            cls = 'btn btn-sm'

            case options[:style]
            when 'danger'
              cls << ' btn-outline-danger'
            end

            attrs = {
              class: cls,
              type: 'submit',
              title: options[:label],
              name: options[:name],
              value: options[:value],
            }

            html.tag('button', attrs) do
              html.icons.icon(options[:icon])
            end
          end
        end
      end
    end
  end
end
