require_relative '../cards/columns/cost'
require_relative '../cards/columns/creature_stats'
require_relative '../cards/columns/identity'
require_relative '../cards/columns/score'
require_relative '../cards/columns/tags'
require_relative '../deck_cards/columns/name'

require_relative 'navigation/list'
require_relative 'navigation/show'
require_relative 'columns/owned_count'

module Web
  module Views
    module FindDecks
      class Show < ::Html::Component
        def draw
          Layout.new(
            ::Html::Navigation.new(
              Navigation::List.new(breadcrumb: true),
              Navigation::Show.new(
                breadcrumb: true, deck: :deck, current: true
              ),
              breadcrumb: true
            ),
            ::Html::Box.new(
              ::Html::Box::Title.new(
                source: :deck, title: :name, count: :card_count
              ),
              ::Html::Table.new(
                Cards::Columns::Score.new(sort: true),
                # TODO: Set to true once sorting fixed.
                Columns::OwnedCount.new(sort: false),
                DeckCards::Columns::Name.new(sort: true),
                Cards::Columns::Tags.new,
                Cards::Columns::Cost.new(sort: true),
                Cards::Columns::Identity.new(sort: true),
                Cards::Columns::CreatureStats.new(sort: true),
                source: :cards
              ),
            ),
          )
        end
      end
    end
  end
end
