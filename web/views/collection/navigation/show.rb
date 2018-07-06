require_relative '../../components/navigation_item'

module Web
  module Views
    module Collection
      module Navigation
        class Show < Components::NavigationItem
          def item_values(context)
            deck = context[options[:deck]]

            ['Collection', '/collection']
          end
        end
      end
    end
  end
end
