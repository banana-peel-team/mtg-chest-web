module Web
  module Views
    module Decks
      module Navigation
        class Edit < ::Html::Navigation::Item
          private

          def item_values(context)
            deck = context[options[:deck]]

            [ 'Edit', "/decks/#{deck[:id]}/edit"]
          end
        end
      end
    end
  end
end
