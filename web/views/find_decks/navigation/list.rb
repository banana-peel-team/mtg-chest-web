require_relative '../../components/navigation_item'

module Web
  module Views
    module FindDecks
      module Navigation
        class List < Components::NavigationItem
          private

          def item_values(context)
            ['Find decks', '/find-decks']
          end
        end
      end
    end
  end
end
