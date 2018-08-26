module Web
  module Views
    module Decks
      module Navigation
        class AddCards < ::Html::Navigation::Item
          private

          def item_values(context)
            deck = context[options[:deck]]

            ['Add cards', "/decks/#{deck[:id]}/add-cards"]
          end
        end
      end
    end
  end
end
