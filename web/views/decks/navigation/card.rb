require_relative '../../components/navigation_item'

module Web
  module Views
    module Decks
      module Navigation
        class Card < Components::NavigationItem
          private

          def item_values(context)
            card = context[options[:card]]

            [card[:name], nil]
          end
        end
      end
    end
  end
end
