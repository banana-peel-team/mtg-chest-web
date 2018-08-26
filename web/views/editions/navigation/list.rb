module Web
  module Views
    module Editions
      module Navigation
        class List < ::Html::Navigation::Item
          private
          def item_values(context)
            ['Editions', '/editions']
          end
        end
      end
    end
  end
end
