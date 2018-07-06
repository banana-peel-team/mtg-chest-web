require_relative '../../components/navigation_item'

module Web
  module Views
    module Decks
      module Navigation
        class LinkCards < Components::NavigationItem
          private

          def item_values(context)
            deck = context[options[:deck]]

            ['Link cards', "/decks/#{deck[:id]}/link"]
          end
        end
      end
    end
  end
end
