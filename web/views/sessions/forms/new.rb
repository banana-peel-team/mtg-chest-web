module Web
  module Views
    module Sessions
      module Forms
        class New < ::Html::Form
          option :class, 'form-signin'
          option :method, 'post'
          option :action, '/sessions'

          def draw
            ::Html::Component.new(
              ::Html::Header.new(text: 'Sign in'),
              ::Html::Form::Group.new(
                field(::Html::Form::TextField, {
                  name: 'username',
                  source: :username,
                  label: 'Username',
                  required: true,
                  errors_texts: { invalid: 'Invalid username or password' },
                }),
              ),
              ::Html::Form::Group.new(
                field(::Html::Form::PasswordField, {
                  name: 'password',
                  source: :password,
                  label: 'Password',
                  required: true,
                  value: nil,
                }),
              ),
              ::Html::Form::Submit.new(label: 'Sign in'),
              *elements
            )
          end
        end
      end
    end
  end
end
