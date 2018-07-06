require_relative '../../components/form'
require_relative '../../components/button_group'
require_relative '../../components/forms/hidden'
require_relative '../../components/forms/button'

module Web
  module Views
    module Decks
      module Forms
        class EditDeckCard < Components::Form
          def build_elements
            flag = options.fetch(:flag) { true }

            new_elements =
              if options[:icon]
                [
                  Components::Forms::Button.new(
                    name: child_name('status'),
                    value: 'flagged',
                    icon: 'flag',
                    label: 'Flag for removal',
                    unless: flag ? :is_flagged : true,
                  ),
                  Components::Forms::Button.new(
                    name: child_name('status'),
                    value: 'unlinked',
                    icon: 'unlink',
                    label: 'Unlink',
                    if: :user_printing_id,
                  ),
                  Components::Forms::Button.new(
                    name: child_name('status'),
                    value: 'removed',
                    icon: 'trash-alt',
                    label: 'Remove',
                    style: 'danger',
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
              Components::ButtonGroup.new(new_elements)
            ]
          end

          def method(_context)
            'post'
          end

          def action(context)
            card = context[:_current_row]

            "/deck-cards/#{card[:deck_card_id]}"
          end
        end
      end
    end
  end
end
