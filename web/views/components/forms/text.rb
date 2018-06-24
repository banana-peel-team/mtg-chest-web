require_relative 'field'

module Web
  module Views
    module Components
      module Forms
        class Text < Field
          def render(html, context)
            input_label(html, @id)

            value = field_value(context)
            errors = input_errors(context)
            cls = 'form-control'
            cls << ' is-invalid' if errors

            html.stag('input', {
              class: cls,
              placeholder: options[:label],
              id: @id,
              name: options[:name],
              type: options[:type],
              value: value,
              required: options[:required],
            })

            error_feedback(html, errors) if errors
          end

          private

          def default_options
            super.merge({
              type: 'text',
            })
          end
        end
      end
    end
  end
end
