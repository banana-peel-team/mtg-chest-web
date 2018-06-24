require_relative '../../components/form'
require_relative '../../components/button_group'
require_relative '../../components/forms/hidden'
require_relative '../../components/forms/text'
require_relative '../../components/forms/select'
require_relative '../../components/forms/submit'
require_relative '../../components/forms/checkbox'
require_relative '../../components/forms/textarea'
require_relative '../../components/form_row'
require_relative '../../components/form_group'
require_relative '../../components/col'

module Web
  module Views
    module Decks
      module Forms
        class New < Components::Form
          def build_elements
            [
              Components::FormGroup.new([
                Components::Forms::Text.new({
                  name: child_name('name'),
                  label: 'Name',
                  required: true,
                }),
              ]),
              Components::FormGroup.new([
                Components::Forms::Textarea.new({
                  name: child_name('list'),
                  label: 'Cards',
                  placeholder: '1 Swamp',
                  required: true,
                }),
              ]),
              Components::Forms::Submit.new(label: 'Create'),
            ]
          end

          def method(_context)
            'post'
          end

          def action(context)
            '/decks/import-list'
          end
        end
      end
    end
  end
end
