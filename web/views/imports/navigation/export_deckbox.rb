module Web
  module Views
    module Imports
      module Navigation
        class ExportDeckbox < ::Html::Navigation::Item
          private

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
