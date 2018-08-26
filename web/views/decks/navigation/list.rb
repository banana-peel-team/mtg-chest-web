module Web
  module Views
    module Decks
      module Navigation
        class List < ::Html::Navigation::Item
          private

          def item_values(context)
            ['Decks', '/decks']
          end
        end
      end
    end
  end
end
