require_relative 'field'

module Web
  module Views
    module Components
      module Forms
        class Textarea < Field
          def render(html, context)
            return unless visible?(context)

            values = context[:_current_form_values] || {}
            field_name = options[:name]
            field_value = values[options[:source]]

            html.tag('textarea', field_value, {
              class: 'form-control',
              name: field_name,
              placeholder: options[:placeholder] || options[:label],
              required: options[:required],
            })
          end
        end
      end
    end
  end
end
