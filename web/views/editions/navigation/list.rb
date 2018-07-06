require_relative '../../components/navigation_item'

module Web
  module Views
    module Editions
      module Navigation
        class List < Components::NavigationItem
          private
          def item_values(context)
            ['Editions', '/editions']
          end
        end
      end
    end
  end
end
