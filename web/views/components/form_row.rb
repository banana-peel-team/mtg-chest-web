require_relative '../component'

module Web
  module Views
    module Components
      class FormRow < Component
        def render(html, context)
          html.tag('div', class: 'form-row mt-3 mb-3') do
            super(html, context)
          end
        end
      end
    end
  end
end
