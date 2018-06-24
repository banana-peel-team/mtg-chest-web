require_relative '../components/navigation'
require_relative '../components/table'

require_relative '../cards/columns/score'
require_relative '../cards/columns/tags'
require_relative '../cards/columns/cost'
require_relative '../cards/columns/identity'
require_relative '../cards/columns/creature_stats'
require_relative '../deck_cards/columns/title'

require_relative 'columns/card_deck'
require_relative 'columns/card_import'
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
            Cards::Columns::Score.new('Score', sort: 'score'),
            DeckCards::Columns::Title.new('Name', sort: 'name'),
            Cards::Columns::Tags.new('Tags'),
            Cards::Columns::Cost.new('Cost', sort: 'cmc'),
            Cards::Columns::Identity.new('Identity', sort: 'identity'),
            Cards::Columns::CreatureStats.new('P/T', sort: true),
            Columns::CardDeck.new('Deck'),
            Columns::CardImport.new('Import'),
          ], source: :printings)
        ], title: 'Your collection')
      ])
    end
  end
end
