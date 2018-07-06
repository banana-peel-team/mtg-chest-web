require_relative '../../components/navigation_item'

module Web
  module Views
    module Imports
      module Navigation
        class ExportDeckbox < Components::NavigationItem
          def item_values(context)
            import = context[options[:import]]

            [
              'Export to deckbox',
              "/collection/imports/#{import[:id]}/deckbox"
            ]
          end
        end
      end
    end
  end
end
