require_relative 'field'

module Web
  module Views
    module Components
      module Forms
        class Hidden < Field
          def render(html, context)
            values = context[:_current_form_values] || {}
            field_name = options[:name]
            field_value = values[options[:source]]
            value = options[:value] || field_value

            return unless value
            value = value.to_s

            return if value.empty?

            html.stag('input', {
              id: @id,
              name: field_name,
              type: 'hidden',
              value: options[:value] || field_value,
            })
          end
        end
      end
    end
  end
end
