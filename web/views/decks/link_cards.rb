require_relative '../components/table'
require_relative '../components/navigation'

require_relative 'link_cards_table'
require_relative 'forms/link_card'
require_relative 'navigation/list'
require_relative 'navigation/show'
require_relative 'navigation/edit'
require_relative 'navigation/link_cards'
require_relative '../imports/columns/title'

module Web
  module Views
    module Decks
      LinkCards = Layout.new([
        Components::Navigation.new([
          Decks::Navigation::List.new(breadcrumb: true),
          Decks::Navigation::Show.new(breadcrumb: true, deck: :deck),
          Decks::Navigation::Edit.new(breadcrumb: true, deck: :deck),
          Decks::Navigation::LinkCards.new(
            breadcrumb: true, deck: :deck, current: true
          ),
        ], breadcrumb: true),
        LinkCardsTable.new,
      ])
    end
  end
end
