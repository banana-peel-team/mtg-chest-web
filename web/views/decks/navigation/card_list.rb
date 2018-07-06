require_relative '../../components/navigation_item'

module Web
  module Views
    module Decks
      module Navigation
        class CardList < Components::NavigationItem
          private

          def item_values(context)
            deck = context[options[:deck]]

            ['Card list', "/decks/#{deck[:id]}/list"]
          end
        end
      end
    end
  end
end
