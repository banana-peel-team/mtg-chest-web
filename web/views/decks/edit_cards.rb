require_relative '../components/table'
require_relative '../components/box'
require_relative '../components/box_title'
require_relative '../components/navigation'

require_relative 'show'
require_relative 'navigation/list'
require_relative 'navigation/show'
require_relative 'navigation/edit'
require_relative 'navigation/add_cards'
require_relative 'navigation/link_cards'
require_relative '../cards/columns/score'
require_relative '../cards/columns/tags'
require_relative '../cards/columns/cost'
require_relative '../cards/columns/identity'
require_relative '../cards/columns/creature_stats'
require_relative '../deck_cards/columns/name'
require_relative 'forms/edit_deck_card'

module Web
  module Views
    module Decks
      EditCards = Layout.new([
        Components::Navigation.new([
          Decks::Navigation::List.new(breadcrumb: true),
          Decks::Navigation::Show.new(breadcrumb: true, deck: :deck),
          Decks::Navigation::Edit.new(
            breadcrumb: true, deck: :deck, current: true
          ),
        ], breadcrumb: true),
        Components::Box.new([
          Components::Navigation.new([
            Decks::Navigation::FindCards.new(deck: :deck),
            Decks::Navigation::LinkCards.new(deck: :deck),
            Decks::Navigation::AddCards.new(deck: :deck),
          ]),
          Components::Table.new([
            Cards::Columns::Score.new(sort: true),
            DeckCards::Columns::Name.new(sort: true),
            Cards::Columns::Tags.new,
            Cards::Columns::Cost.new(sort: true),
            Cards::Columns::Identity.new(sort: true),
            Cards::Columns::CreatureStats.new(sort: true),
            Components::TableColumn.new([
              Forms::EditDeckCard.new({
                source: :_current_row, icon: true, inline: true
              }),
            ], title: 'Actions'),
          ], source: :cards),
        ], title: 'Edit cards'),
        Components::Box.new([
          Components::Table.new([
            Cards::Columns::Score.new(sort: true),
            DeckCards::Columns::Name.new(sort: true),
            Cards::Columns::Tags.new,
            Cards::Columns::Cost.new(sort: true),
            Cards::Columns::Identity.new(sort: true),
            Cards::Columns::CreatureStats.new(sort: true),
            Components::TableColumn.new([
              Forms::EditDeckCard.new({
                flag: false, source: :_current_row, icon: true, inline: true
              }),
            ], title: 'Actions'),
          ], source: :scratchpad),
        ], title: 'Scratchpad'),
      ])
    end
  end
end
