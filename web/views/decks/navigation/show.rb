require_relative '../../components/navigation_item'

module Web
  module Views
    module Decks
      module Navigation
        class Show < Components::NavigationItem
          private

          def item_values(context)
            deck = context[options[:deck]]

            [deck[:name], "/decks/#{deck[:id]}"]
          end
        end
      end
    end
  end
end
