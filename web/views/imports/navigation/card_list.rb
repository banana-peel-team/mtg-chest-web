module Web
  module Views
    module Imports
      module Navigation
        class CardList < ::Html::Navigation::Item
          private

          def item_values(context)
            import = context[options[:import]]

            ['Card list', "/collection/imports/#{import[:id]}/list"]
          end
        end
      end
    end
  end
end
