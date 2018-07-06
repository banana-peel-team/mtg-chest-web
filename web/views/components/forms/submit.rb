require_relative 'field'

module Web
  module Views
    module Components
      module Forms
        class Submit < Field
          def render(html, context)
            cls = 'btn btn-primary'
            cls << ' ' + options[:class] if options[:class]

            html.stag('input', {
              type: 'submit',
              class: cls,
              value: options[:label],
            })
          end
        end
      end
    end
  end
end
