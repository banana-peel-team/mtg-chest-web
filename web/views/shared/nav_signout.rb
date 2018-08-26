module Web
  module Views
    module Shared
      class NavSignout < ::Html::Form
        option :action, '/sessions'
        option :method, 'delete'

        def draw
          ::Html::Form::Button.new(
            icon: 'sign-out-alt', label: 'Sign out'
          )
        end

        def render(html, context)
          html.tag('div', class: 'align-right') do
            super(html, context)
          end
        end
      end
    end
  end
end
