module Web
  module Views
    module FindDecks
      module Navigation
        class List < ::Html::Navigation::Item
          private

          def item_values(context)
            ['Find decks', '/find-decks']
          end
        end
      end
    end
  end
end
