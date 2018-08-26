module Web
  module Views
    module Cards
      module Navigation
        class Database < ::Html::Navigation::Item
          private

          def item_values(_context)
            ['Card database', '/cards']
          end
        end
      end
    end
  end
end
