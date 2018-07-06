require_relative '../../component'

module Web
  module Views
    module Components
      module Forms
        class Field < Component
          def initialize(options)
            super(options)

            @id = tag_id(options[:name], options[:id])
          end

          def render(html, context)
          end

          private

          def input_label(html, id)
            label = options[:label]
            return unless label

            html.tag('label', label, class: 'sr-only', for: id)
          end

          def error_feedback(html, errors)
            errors.each do |text|
              html.tag('div', text, class: 'invalid-feedback')
            end
          end

          def field_value(context)
            value = options[:value]
            return value if value

            values = context[:_current_form_values]
            return unless values

            values[options[:source]]
          end

          def input_errors(context)
            form_errors = context[:_current_form_errors]
            return unless form_errors

            errors = form_errors[options[:source]]

            return unless errors
            return [] if errors == true

            override_texts = options[:errors_texts] || {}
            errors.map do |error|
              override_texts[error] || DEFAULT_ERRORS[error]
            end
          end

          def visible?(context)
            if options.key?(:if)
              _if = options[:if]
              return _if unless _if.is_a?(Symbol)

              source = context[:_current_form_values]
              return source[_if]
            end

            if options.key?(:unless)
              _unless = options[:unless]

              return !_unless unless _unless.is_a?(Symbol)

              source = context[:_current_form_values]
              return !source[_unless]
            end

            true
          end
        end
      end
    end
  end
end
