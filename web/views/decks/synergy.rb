require_relative '../components/row'
require_relative '../components/navigation'
require_relative '../components/box'
require_relative '../components/table'
require_relative '../components/table_column'

require_relative '../cards/columns/score'
require_relative '../cards/columns/tags'
require_relative '../cards/columns/cost'
require_relative '../cards/columns/identity'
require_relative '../cards/columns/creature_stats'
require_relative '../deck_cards/columns/title'

require_relative 'show'
require_relative 'navigation/list'
require_relative 'navigation/show'
require_relative 'navigation/card'
require_relative 'navigation/synergy'
require_relative 'forms/add_card'


module Web
  module Views
    module Decks
      Synergy = Layout.new([
        Components::Row.new([
          Components::Navigation.new([
            Navigation::List.new(breadcrumb: true),
            Navigation::Show.new(breadcrumb: true, deck: :deck),
            Navigation::Card.new(breadcrumb: true, card: :card),
            Navigation::Synergy.new(
              breadcrumb: true, deck: :deck, current: true
            ),
          ], breadcrumb: true),
        ]),
        Components::Box.new([
          Components::Table.new([
            Cards::Columns::Score.new('Score'),
            DeckCards::Columns::Title.new('Name', count: false),
            Cards::Columns::Tags.new('Tags'),
            Cards::Columns::Cost.new('Cost'),
            Cards::Columns::Identity.new('Identity'),
            Cards::Columns::CreatureStats.new('P/T'),
            Components::TableColumn.new('Actions', [
              Forms::AddCard.new(
                icon: true, inline: true, source: :_current_row
              ),
            ]),
          ], source: :cards),
        ], title: 'Compatible cards on your collection'),
      ])
    end
  end
end
