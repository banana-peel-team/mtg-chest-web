module Web
  module Views
    module Extensions
      module Form
        class Extension
          DEFAULT_ERRORS = {
            invalid: 'This field is invalid',
            required: 'This field is required',
          }.freeze

          attr_reader :html

          def initialize(html, options)
            @html = html
            @options = options
          end

          def input_hidden(name, value)
            html.append_html(
              %Q(<input type="hidden" name="#{name}" value="#{html.e(value)}">)
            )
          end

          def button_group(&block)
            html.tag('div', class: 'btn-group', &block)
          end

          def button(text, name = nil, value = nil, options)
            cls = 'btn'
            cls << ' btn-sm' if options[:small]

            case options[:style]
            when :danger
              cls << ' btn-outline-danger'
            when :light
              cls << ' btn-light'
            end

            attrs = {
              class: cls,
              name: name,
              value: value,
              title: text,
              type: 'submit',
            }

            if options[:icon]
              html.tag('button', attrs) do
                html.icons.icon(options[:icon])
              end
            else
              html.tag('button', text, attrs)
            end
          end

          def render(attrs = {}, &block)
            attrs = { method: 'post', action: @options[:action] }.merge(attrs)

            html.tag('form', attrs) do
              token = @options[:csrf_token]
              if attrs[:method] != 'get' && !token.empty?
                input_hidden('csrf_token', token)
              end

              block.call(self)
            end
          end

          def row(&block)
            html.tag('div', class: 'form-row mt-3 mb-3', &block)
          end

          def group(&block)
            html.tag('div', class: 'form-group', &block)
          end

          def submit(label, attrs = {})
            cls = 'btn btn-primary'

            if attrs[:class]
              cls << ' ' + attrs[:class]
            end

            html.stag('input', type: 'submit', class: cls, value: label)
          end

          def error_feedback(text)
            html.tag('div', text, class: 'invalid-feedback')
          end

          def file(name, attrs)
            field_id = input_id(name, attrs[:id])
            field_name = input_name(name)

            html.tag('div', class: 'custom-file') do
              html.stag('input', {
                id: field_id,
                name: field_name,
                type: 'file',
                class: 'custom-file-input',
                required: attrs[:required],
              })

              html.tag('label', attrs[:label] || 'Choose file', {
                class: 'custom-file-label',
                for: field_id,
              })
            end
          end

          def textarea(name, attrs)
            field_name = input_name(name)

            html.tag('textarea', {
              class: 'form-control',
              name: field_name,
              placeholder: attrs[:placeholder] || attrs[:label],
              required: attrs[:required],
            })
          end

          def select(name, options)
            field_name = input_name(name)

            html.tag('select', {
              name: field_name,
              class: 'form-control',
            }) do
              options.each do |value, label|
                html.tag('option', label, value: value)
              end
            end
          end

          # TODO: duplicated code, see +radiobox+
          def checkbox(name, attrs)
            field_id = input_id(name, attrs[:id], attrs[:value])
            field_name = input_name(name)

            # TODO: not inline
            if attrs[:inline]
              html.tag('div', class: 'form-check form-check-inline') do
                html.stag('input', {
                  name: field_name,
                  type: 'checkbox',
                  class: 'form-check-input',
                  id: field_id,
                  value: attrs[:value],
                  checked: attrs[:checked],
                })

                if attrs[:label]
                  html.tag('label', attrs[:label], {
                    class: 'form-check-label',
                    for: field_id
                  })
                end
              end
            end
          end

          def radiobox(name, attrs)
            field_id = input_id(name, attrs[:id])
            field_name = input_name(name)

            # TODO: not inline
            if attrs[:inline]
              html.tag('div', class: 'form-check form-check-inline') do
                html.stag('input', {
                  name: field_name,
                  type: 'radio',
                  class: 'form-check-input',
                  id: field_id,
                  value: attrs[:value],
                })

                if attrs[:label]
                  html.tag('label', attrs[:label], {
                    class: 'form-check-label',
                    for: field_id
                  })
                end
              end
            end
          end

          def input(type, name, attrs, &block)
            id = input_id(name, attrs[:id])
            field_name = input_name(name)

            errors_texts = input_errors(name, attrs[:errors_texts])
            field_value = form_values[name]

            cls = 'form-control'
            cls << ' is-invalid' if errors_texts

            if attrs[:label]
              html.tag('label', attrs[:label], class: 'sr-only', for: id)
            end

            html.stag('input', {
              id: id,
              name: field_name,
              type: type,
              class: cls,
              value: attrs[:value] || field_value,
              placeholder: attrs[:label],
              required: attrs[:required],
            })

            if errors_texts
              errors_texts.each do |error_text|
                error_feedback(error_text)
              end
            end
          end

          def input_id(name, *suffixes)
            id = "#{id_base}-#{name}"
            id << "-#{suffixes.join('-')}" if suffixes.any?

            fix_id(id)
          end

          def input_name(name)
            return name unless @options[:namespace]

            "#{@options[:namespace]}[#{name}]"
          end

          private

          # Returns a list of the error messages
          #
          # Returns nil if no errors.
          # Returns [] if there are errors, but there
          # is no relevant message. This still means the
          # field is invalid.
          def input_errors(name, override_texts)
            errors = form_errors[name]
            return unless errors
            return [] if errors == true

            override_texts ||= {}
            errors.map do |error|
              override_texts[error] || DEFAULT_ERRORS[error]
            end
          end

          def form_errors
            @form_errors ||= @options[:errors] || {}
          end

          def form_values
            @form_values ||= @options[:values] || {}
          end

          def fix_id(id)
            id.gsub(/[\[\]-]+/, '-').chomp('-')
          end

          def id_base
            @id_base ||=
              if @options[:namespace]
                @options[:namespace]
              else
                'form-field'
              end
          end
        end

        def delete_form(opts, &block)
          form(opts) do |f|
            f.input_hidden('_method', 'delete') if opts[:method] != 'get'

            block.call(f)
          end
        end

        def form(options, &block)
          element = Web::Views::Extensions::Form::Extension.new(self, {
            csrf_token: @csrf_token,
          }.merge(options))

          if block_given?
            element.render(options, &block)
          else
            element
          end
        end
      end
    end
  end
end
