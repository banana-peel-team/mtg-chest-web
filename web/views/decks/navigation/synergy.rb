module Web
  module Views
    module Decks
      module Navigation
        class Synergy < ::Html::Navigation::Item
          private

          def item_values(context)
            deck = context[options[:deck]]

            ['Synergy', "/decks/#{deck[:id]}/list"]
          end
        end
      end
    end
  end
end
