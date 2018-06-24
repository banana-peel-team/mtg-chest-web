require_relative '../component'

module Web
  module Views
    module Components
      class Form < Component
        def render(html, context)
          if (source = options[:source])
            data = form_data(context)

            context = context.merge(
              _current_form_values: data[source],
              _current_form_errors: form_errors(data),
            )
          end

          form_method = method(context)
          attr_method =
            if %w(get post).include?(form_method)
              form_method
            else
              'post'
            end

          attrs = {
            class: options[:class],
            method: attr_method,
            action: action(context),
            enctype: options[:multipart] ? 'multipart/form-data' : nil,
          }

          html.tag('form', attrs) do
            token = context[:csrf_token]
            if attr_method != form_method
              input_hidden(html, '_method', form_method)
            end

            if form_method != 'get' && token && !token.empty?
              input_hidden(html, 'csrf_token', token)
            end

            super(html, context)
          end
        end

        private

        def form_errors(data)
          errors_key = options[:errors]
          return {} unless errors_key

          data[errors_key]
        end

        def form_data(context)
          form_key = options[:form]
          return context[form_key] if form_key

          context
        end

        def input_hidden(html, name, value)
          html.append_html(
            %Q(<input type="hidden" name="#{name}" value="#{html.e(value)}">)
          )
        end

        def method(context)
          options[:method] || context[:method]
        end

        def action(context)
          options[:action] || context[:action]
        end
      end
    end
  end
end
