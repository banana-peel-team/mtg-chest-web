require_relative '../../components/form'
require_relative '../../components/button_group'
require_relative '../../components/forms/hidden'
require_relative '../../components/forms/button'

module Web
  module Views
    module Decks
      module Forms
        class AddCard < Components::Form
          def build_elements
            new_elements =
              if options[:icon]
                [
                  Components::Forms::Button.new(
                    name: child_name('slot'),
                    value: 'deck',
                    icon: 'plus',
                    label: 'Add to deck',
                  ),
                  Components::Forms::Button.new(
                    name: child_name('slot'),
                    value: 'scratchpad',
                    icon: 'pencil-alt',
                    label: 'Add to scratchpad',
                  ),
                  Components::Forms::Button.new(
                    name: child_name('slot'),
                    value: 'ignored',
                    icon: 'thumbs-down',
                    label: 'Ignore this card',
                  ),
                ]
              else
                raise 'Not implemented.'
              end

            [
              Components::Forms::Hidden.new(
                name: child_name('card_id'),
                type: 'hidden',
                source: :card_id,
              ),
              Components::Forms::Hidden.new(
                name: child_name('user_printing_id'),
                type: 'hidden',
                source: :user_printing_id,
              ),
              Components::ButtonGroup.new(new_elements)
            ]
          end

          def method(_context)
            'post'
          end

          def action(context)
            "/decks/#{context[:deck][:id]}/cards"
          end
        end
      end
    end
  end
end
