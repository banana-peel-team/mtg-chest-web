require_relative '../../components/navigation_item'

module Web
  module Views
    module Decks
      module Navigation
        class List < Components::NavigationItem
          private

          def item_values(context)
            ['Decks', '/decks']
          end
        end
      end
    end
  end
end
