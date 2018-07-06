require_relative '../components/navigation'
require_relative '../components/box'

require_relative 'navigation/list'
require_relative 'navigation/show'
require_relative 'navigation/edit'
require_relative 'navigation/card_list'
require_relative '../deck_cards/card_list'

module Web
  module Views
    module Decks
      CardList = Layout.new([
        Components::Navigation.new([
          Navigation::List.new(breadcrumb: true),
          Navigation::Show.new(breadcrumb: true, deck: :deck),
          Navigation::CardList.new(
            breadcrumb: true, deck: :deck, current: true
          ),
        ], breadcrumb: true),
        Components::Box.new([
          DeckCards::CardList.new(source: :cards),
        ], title: 'Card list'),
      ])
    end
  end
end
