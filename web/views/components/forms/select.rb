require_relative 'field'

module Web
  module Views
    module Components
      module Forms
        class Select < Field
          def render(html, context)
            values = context[:_current_form_values] || {}
            field_name = options[:name]
            field_value = values[options[:source]]
            # FIXME: This creates fields with duplicated ids
            #        if there are two forms with th same name.
            field_id = tag_id(field_name, options[:id])

            if options[:label]
              html.tag('label', options[:label], {
                class: 'sr-only', for: field_id
              })
            end

            html.tag('select', {
              class: 'form-control',
              id: field_id,
              name: field_name,
              required: options[:required],
            }) do
              options[:options].each do |value, label|
                html.tag('option', label, {
                  value: value,
                  selected: (value == field_value) ? 'selected' : nil,
                })
              end
            end
          end
        end
      end
    end
  end
end
