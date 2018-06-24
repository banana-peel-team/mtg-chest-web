require_relative '../../components/form'
require_relative '../../components/forms/button'

module Web
  module Views
    module Decks
      module Forms
        class DeleteDeck < Components::Form
          def build_elements
            if options[:icon]
              [
                Components::Forms::Button.new(
                  icon: 'trash-alt', label: 'delete', style: 'danger'
                )
              ]
            else
              raise 'Not implemented.'
            end
          end

          def method(_context)
            'delete'
          end

          def action(context)
            deck = context[:_current_row]

            "/decks/#{deck[:id]}"
          end
        end
      end
    end
  end
end
