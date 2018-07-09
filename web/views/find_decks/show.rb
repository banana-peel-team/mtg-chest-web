require_relative '../cards/columns/cost'
require_relative '../components/table_column'
require_relative '../cards/columns/creature_stats'
require_relative '../cards/columns/identity'
require_relative '../cards/columns/score'
require_relative '../cards/columns/tags'
require_relative '../components/box'
require_relative '../components/box_title'
require_relative '../components/navigation'
require_relative '../deck_cards/columns/name'
require_relative '../components/row'

require_relative '../decks/navigation/find_cards'
require_relative 'navigation/list'
require_relative '../decks/navigation/show'
require_relative 'columns/owned_count'

module Web
  module Views
    module FindDecks
      Show = Layout.new([
        Components::Navigation.new([
          Navigation::List.new(breadcrumb: true),
          Decks::Navigation::Show.new(
            breadcrumb: true, deck: :deck, current: true
          ),
        ], breadcrumb: true),
        Components::Box.new([
          Components::BoxTitle.new(
            source: :deck, title: :name, count: :card_count
          ),
          Components::Table.new([
            Cards::Columns::Score.new(sort: true),
            # TODO: Set to true once sorting fixed.
            Columns::OwnedCount.new(sort: false),
            DeckCards::Columns::Name.new(sort: true),
            Cards::Columns::Tags.new,
            Cards::Columns::Cost.new(sort: true),
            Cards::Columns::Identity.new(sort: true),
            Cards::Columns::CreatureStats.new(sort: true),
          ], source: :cards),
        ]),
      ])
    end
  end
end
