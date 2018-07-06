require_relative 'field'

module Web
  module Views
    module Components
      module Forms
        # FIXME: Duplicated code, see +Checkbox+
        class Radiobox < Field
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
                  type: 'radio',
                  class: 'form-check-input',
                  id: field_id,
                  value: value,
                  checked: checked,
                })

                if options[:label]
                  html.tag('label', options[:label], {
                    class: 'form-check-label',
                    for: field_id
                  })
                end
              end
            else
              raise 'not implemented'
            end
          end
        end
      end
    end
  end
end
