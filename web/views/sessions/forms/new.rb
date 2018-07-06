# TODO: cleanup this list
require_relative '../../components/form'
require_relative '../../components/button_group'
require_relative '../../components/forms/hidden'
require_relative '../../components/forms/text'
require_relative '../../components/forms/select'
require_relative '../../components/forms/submit'
require_relative '../../components/forms/checkbox'
require_relative '../../components/forms/textarea'
require_relative '../../components/forms/password'
require_relative '../../components/form_row'
require_relative '../../components/form_group'
require_relative '../../components/col'

require_relative '../title'

module Web
  module Views
    module Sessions
      module Forms
        class New < Components::Form
          def build_elements
            [
              Title.new('Sign in'),
              Components::FormGroup.new([
                Components::Forms::Text.new({
                  name: child_name('username'),
                  source: :username,
                  label: 'Username',
                  required: true,
                  errors_texts: { invalid: 'Invalid username or password' },
                }),
              ]),
              Components::FormGroup.new([
                Components::Forms::Password.new({
                  name: child_name('password'),
                  source: :password,
                  label: 'Password',
                  placeholder: '1 Swamp',
                  required: true,
                  value: nil,
                }),
              ]),
              Components::Forms::Submit.new(label: 'Sign in'),
            ]
          end

          def default_options
            {
              class: 'form-signin'
            }
          end

          def method(_context)
            'post'
          end

          def action(context)
            '/sessions'
          end
        end
      end
    end
  end
end
