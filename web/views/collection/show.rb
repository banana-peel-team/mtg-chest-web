require_relative '../components/navigation'
require_relative '../components/table'

require_relative '../cards/columns/score'
require_relative '../cards/columns/tags'
require_relative '../cards/columns/cost'
require_relative '../cards/columns/identity'
require_relative '../cards/columns/creature_stats'
require_relative '../deck_cards/columns/name'

require_relative '../decks/columns/name'
require_relative '../imports/columns/title'
require_relative 'navigation/show'

module Web
  module Views
    module Collection
      Show = Layout.new([
        Components::Navigation.new([
          Collection::Navigation::Show.new(breadcrumb: true, current: true),
        ], breadcrumb: true),
        Components::Box.new([
          Components::Table.new([
            Cards::Columns::Score.new(sort: true),
            DeckCards::Columns::Name.new(sort: true),
            Cards::Columns::Tags.new,
            Cards::Columns::Cost.new(sort: true),
            Cards::Columns::Identity.new(sort: true),
            Cards::Columns::CreatureStats.new(sort: true),
            Decks::Columns::Name.new(sort: true),
            Imports::Columns::Title.new(sort: true),
          ], source: :printings)
        ], title: 'Your collection')
      ])
    end
  end
end
