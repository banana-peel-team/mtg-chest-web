require_relative '../../components/navigation_item'

module Web
  module Views
    module Imports
      module Navigation
        class Show < Components::NavigationItem
          def item_values(context)
            import = context[options[:import]]

            [import[:title], "/collection/imports/#{import[:id]}"]
          end
        end
      end
    end
  end
end
