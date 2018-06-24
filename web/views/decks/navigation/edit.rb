require_relative '../../components/navigation_item'

module Web
  module Views
    module Decks
      module Navigation
        class Edit < Components::NavigationItem
          private

          def item_values(context)
            deck = context[options[:deck]]

            [ 'Edit', "/decks/#{deck[:id]}/edit"]
          end
        end
      end
    end
  end
end
