module Web
  module Views
    module Decks
      module Navigation
        class New < ::Html::Navigation::Item
          private

          def item_values(context)
            ['New', '/decks/new']
          end
        end
      end
    end
  end
end
