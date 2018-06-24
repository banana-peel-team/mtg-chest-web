require_relative '../../components/form'
require_relative '../../components/button_group'
require_relative '../../components/forms/hidden'
#require_relative '../../components/forms/button'
require_relative '../../components/forms/submit'
require_relative '../../components/forms/checkbox'
require_relative '../../components/forms/textarea'
require_relative '../../components/form_row'

module Web
  module Views
    module Decks
      module Forms
        class AddCards < Components::Form
          def build_elements
            [
              Components::Forms::Checkbox.new(
                name: child_name('scratchpad'),
                label: 'Scratchpad',
                inline: true,
              ),
              Components::FormRow.new([
                Components::Forms::Textarea.new(
                  name: child_name('list'),
                  label: 'Cards',
                  placeholder: '1 Swamp',
                ),
              ]),
              Components::FormRow.new([
                Components::Forms::Submit.new(label: 'Add')
              ]),
            ]
          end

          def method(_context)
            'post'
          end

          def action(context)
            "/decks/#{context[:deck][:id]}/add-cards"
          end
        end
      end
    end
  end
end
