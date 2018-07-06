require_relative '../../components/navigation_item'

module Web
  module Views
    module Imports
      module Navigation
        class List < Components::NavigationItem
          private
          def item_values(context)
            ['Imports', '/collection/imports']
          end
        end
      end
    end
  end
end
