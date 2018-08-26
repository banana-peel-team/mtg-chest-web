require_relative 'navigation/list'
require_relative 'navigation/show'
require_relative 'navigation/edit'
require_relative 'navigation/add_cards'
require_relative 'forms/add_cards'

module Web
  module Views
    module Decks
      class AddCards < ::Html::Component
        def draw
          Layout.new(
            ::Html::Navigation.new(
              Navigation::List.new(breadcrumb: true),
              Navigation::Show.new(breadcrumb: true, deck: :deck),
              Navigation::Edit.new(breadcrumb: true, deck: :deck),
              Navigation::AddCards.new(
                breadcrumb: true, deck: :deck, current: true,
              ),
              breadcrumb: true
            ),
            ::Html::Card.new(
              Forms::AddCards.new(namespace: 'deck'),
              title: 'Add cards'
            ),
          )
        end
      end
    end
  end
end
