require_relative '../../components/navigation_item'

module Web
  module Views
    module Imports
      module Navigation
        class CardList < Components::NavigationItem
          def item_values(context)
            import = context[options[:import]]

            ['Card list', "/collection/imports/#{import[:id]}/list"]
          end
        end
      end
    end
  end
end
