require_relative '../component'
require_relative '../components/form'
require_relative '../components/forms/button'

module Web
  module Views
    module Shared
      class NavSignout < Components::Form
        def render(html, context)
          html.tag('div', class: 'align-right') do
            super(html, context)
          end
        end

        private

        def build_elements
          [
            Components::Forms::Button.new(
              icon: 'sign-out-alt', label: 'Sign out'
            )
          ]
        end

        def action(_context)
          '/session/delete'
        end

        def method(_context)
          'delete'
        end
      end
    end
  end
end
