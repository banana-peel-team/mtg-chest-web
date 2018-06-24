require_relative '../components/container'

require_relative 'forms/new'

module Web
  module Views
    module Sessions
      New = Layout.new([
        Components::Container.new([
          Forms::New.new({
            name: 'signin',
            form: :user,
            errors: :errors,
            source: :values,
          }),
        ]),
      ])

      class NewA
        attr_reader :options

        def initialize(options)
          @options = options.dup
          @presenter = @options.delete(:presenter)
        end

        def render
          layout = Web::Views::Layout.new(options)

          layout.render do |html|
            html.tag('div', class: 'container') do
              form = html.form(
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
