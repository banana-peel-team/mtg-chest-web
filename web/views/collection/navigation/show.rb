module Web
  module Views
    module Collection
      module Navigation
        class Show < ::Html::Navigation::Item
          def item_values(context)
            deck = context[options[:deck]]

            ['Collection', '/collection']
          end
        end
      end
    end
  end
end
