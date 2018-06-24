require_relative 'field'

module Web
  module Views
    module Components
      module Forms
        class File < Field
          def render(html, context)
            name = options[:name]

            field_id = tag_id(name, options[:id])

            html.tag('div', class: 'custom-file') do
              html.stag('input', {
                id: field_id,
                name: name,
                type: 'file',
                class: 'custom-file-input',
                required: options[:required],
              })

              html.tag('label', options[:label] || 'Choose file', {
                class: 'custom-file-label',
                for: field_id,
              })
            end
          end
        end
      end
    end
  end
end
