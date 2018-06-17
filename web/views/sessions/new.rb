module Web
  module Views
    module Sessions
      class New
        def initialize(attrs)
          @presenter = attrs[:presenter]
          @csrf_token = attrs[:csrf_token]
        end

        def render
          layout = Web::Views::Layout.new(
            csrf_token: @csrf_token,
          )

          layout.render do |html|
            html.tag('div', class: 'container') do
              form = HtmlForm.new(
                html: html,
                namespace: 'signin',
                errors: @presenter.errors,
                values: @presenter.values,
              )

              form.render(action: '/sessions', class: 'form-signin') do
                html.tag('h2', 'Sign in', class: 'form-signin-heading')

                form.group do
                  form.input('text', :username, {
                    label: 'Username',
                    required: true,
                    errors_texts: { invalid: 'Invalid username or passowrd' }
                  })
                end

                form.group do
                  form.input('password', :password, {
                    label: 'Password',
                    required: true,
                    value: nil
                  })
                end

                form.submit('Sign in', class: 'btn-lg btn-block')
              end
            end
          end
        end
      end
    end
  end
end
