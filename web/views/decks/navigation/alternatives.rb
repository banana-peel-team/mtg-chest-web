module Web
  module Views
    module Decks
      module Navigation
        class Alternatives < ::Html::Navigation::Item
          private

          def item_values(context)
            deck = context[options[:deck]]

            ['Alternatives', "/decks/#{deck[:id]}/list"]
          end
        end
      end
    end
  end
end
