module Web
  module Views
    module Decks
      module Navigation
        class Card < ::Html::Navigation::Item
          private

          def item_values(context)
            card = context[options[:card]]

            [card[:name], nil]
          end
        end
      end
    end
  end
end
