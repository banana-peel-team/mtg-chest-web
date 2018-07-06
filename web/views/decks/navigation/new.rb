require_relative '../../components/navigation_item'

module Web
  module Views
    module Decks
      module Navigation
        class New < Components::NavigationItem
          private

          def item_values(context)
            ['New', '/decks/new']
          end
        end
      end
    end
  end
end
