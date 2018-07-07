require_relative 'field'

module Web
  module Views
    module Components
      module Forms
        class Checkbox < Field
          def render(html, context)
            values = context[:_current_form_values] || {}

            name = options[:name]
            value = options[:value] || '1'
            checked = context[:checked] || values[options[:source]] == value
            field_id = tag_id(name, options[:id], value)

            # TODO: not inline
            if options[:inline]
              html.tag('div', class: 'form-check form-check-inline') do
                html.stag('input', {
                  name: name,
                  type: 'checkbox',
                  class: 'form-check-input',
                  id: field_id,
                  value: value,
                  checked: checked,
                })

                input_label(html, field_id)
              end
            else
              raise 'not implemented'
            end
          end

          private

          def input_label(html, id)
            label = options[:label]
            return unless label

            html.tag('label', label, class: 'form-check-label', for: id)
          end
        end
      end
    end
  end
end
