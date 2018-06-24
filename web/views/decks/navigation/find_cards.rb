require_relative '../../components/navigation_item'

module Web
  module Views
    module Decks
      module Navigation
        class FindCards < Components::NavigationItem
          private

          def item_values(context)
            deck = context[options[:deck]]

            ['Find cards', "/decks/#{deck[:id]}/find-cards"]
          end
        end
      end
    end
  end
end
