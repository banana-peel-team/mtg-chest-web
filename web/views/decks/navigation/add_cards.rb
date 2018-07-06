require_relative '../../components/navigation_item'

module Web
  module Views
    module Decks
      module Navigation
        class AddCards < Components::NavigationItem
          private

          def item_values(context)
            deck = context[options[:deck]]

            ['Add cards', "/decks/#{deck[:id]}/add-cards"]
          end
        end
      end
    end
  end
end
