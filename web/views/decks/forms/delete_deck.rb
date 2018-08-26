module Web
  module Views
    module Decks
      module Forms
        class DeleteDeck < ::Html::Form
          option :method, 'delete'

          def draw
            if options[:icon]
              ::Html::Form::Button.new(
                icon: 'trash-alt', label: 'delete', style: 'danger'
              )
            else
              raise 'Not implemented.'
            end
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
