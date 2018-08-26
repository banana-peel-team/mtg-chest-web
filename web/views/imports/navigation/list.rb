module Web
  module Views
    module Imports
      module Navigation
        class List < ::Html::Navigation::Item
          private

          def item_values(context)
            ['Imports', '/collection/imports']
          end
        end
      end
    end
  end
end
