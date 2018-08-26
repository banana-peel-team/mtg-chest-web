require_relative '../cards/columns/cost'
require_relative '../cards/columns/creature_stats'
require_relative '../cards/columns/identity'
require_relative '../cards/columns/score'
require_relative '../cards/columns/tags'
require_relative '../deck_cards/columns/name'
require_relative '../decks/columns/name'

require_relative 'navigation/list'
require_relative 'navigation/show'
require_relative 'navigation/card_list'
require_relative 'navigation/export_deckbox'

module Web
  module Views
    module Imports
      class Show < ::Html::Component
        def draw
          Layout.new(
            ::Html::Navigation.new(
              Navigation::List.new(breadcrumb: true),
              Navigation::Show.new(
                import: :import, breadcrumb: true, current: true
              ),
              breadcrumb: true
            ),

            ::Html::Box.new(
              ::Html::Box::Title.new(
                source: :import, title: :title, count: :user_printing_count
              ),
              ::Html::Navigation.new(
                Navigation::CardList.new(import: :import),
                Navigation::ExportDeckbox.new(import: :import),
              ),
              ::Html::Table.new(
                Cards::Columns::Score.new(sort: 'score'),
                DeckCards::Columns::Name.new(sort: 'name'),
                Cards::Columns::Tags.new,
                Cards::Columns::Cost.new(sort: 'cmc'),
                Cards::Columns::Identity.new(sort: 'identity'),
                Cards::Columns::CreatureStats.new(sort: true),
                Decks::Columns::Name.new(sort: true),
                source: :printings
              ),
            ),
          )
        end
      end
    end
  end
end
