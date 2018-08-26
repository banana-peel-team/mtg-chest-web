module Web
  module Views
    module Imports
      module Navigation
        class New < ::Html::Navigation::Item
          private

          def item_values(context)
            ['New', '/collection/import']
          end
        end
      end
    end
  end
end
