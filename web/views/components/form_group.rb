require_relative '../component'

module Web
  module Views
    module Components
      class FormGroup < Component
        def render(html, context)
          html.tag('div', class: 'form-group') do
            super(html, context)
          end
        end
      end
    end
  end
end
