require_relative 'navigation/list'
require_relative 'navigation/show'
require_relative 'navigation/card_list'
require_relative '../deck_cards/card_list'

module Web
  module Views
    module Imports
      class CardList < ::Html::Component
        def draw
          Layout.new(
            ::Html::Navigation.new(
              Navigation::List.new(breadcrumb: true),
              Navigation::Show.new(import: :import, breadcrumb: true),
              Navigation::CardList.new(
                import: :import, breadcrumb: true, current: true
              ),
              breadcrumb: true
            ),
            ::Html::Box.new(
              DeckCards::CardList.new(source: :cards),
              title: 'Card list'
            )
          )
        end
      end
    end
  end
end
