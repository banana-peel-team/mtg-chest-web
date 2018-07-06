require_relative '../cards/columns/cost'
require_relative '../components/table_column'
require_relative '../cards/columns/creature_stats'
require_relative '../cards/columns/identity'
require_relative '../cards/columns/score'
require_relative '../cards/columns/tags'
require_relative '../components/box'
require_relative '../components/box_title'
require_relative '../components/navigation'
require_relative '../deck_cards/columns/title'
require_relative '../components/row'

require_relative 'navigation/find_cards'
require_relative 'navigation/list'
require_relative 'navigation/show'
require_relative 'navigation/card_list'
require_relative 'navigation/edit'
require_relative 'columns/deck_card_actions'

module Web
  module Views
    module Decks
      Show = Layout.new([
        Components::Navigation.new([
          Decks::Navigation::List.new(breadcrumb: true),
          Decks::Navigation::Show.new(
            breadcrumb: true, deck: :deck, current: true
          ),
        ], breadcrumb: true),
        Components::Box.new([
          Components::BoxTitle.new(
            source: :deck, title: :name, count: :card_count
          ),
          Components::Navigation.new([
            Decks::Navigation::CardList.new(deck: :deck),
            Decks::Navigation::Edit.new(deck: :deck),
          ]),
          Components::Table.new([
            Cards::Columns::Score.new('Score', sort: 'score'),
            DeckCards::Columns::Title.new('Name', sort: 'name'),
            Cards::Columns::Tags.new('Tags'),
            Cards::Columns::Cost.new('Cost', sort: 'cost'),
            Cards::Columns::Identity.new('Identity', sort: 'identity'),
            Cards::Columns::CreatureStats.new('P/T', sort: true),
            Decks::Columns::DeckCardActions.new('Actions'),
          ], source: :cards),
        ]),
      ])
    end
  end
end
