require_relative '../../components/navigation_item'

module Web
  module Views
    module Imports
      module Navigation
        class New < Components::NavigationItem
          private
          def item_values(context)
            ['New', '/collection/import']
          end
        end
      end
    end
  end
end
