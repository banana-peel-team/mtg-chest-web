module Web
  module Views
    module FindDecks
      module Navigation
        class Show < ::Html::Navigation::Item
          private

          def item_values(context)
            deck = context[options[:deck]]

            [deck[:name], "/find-decks/decks/#{deck[:id]}"]
          end
        end
      end
    end
  end
end
