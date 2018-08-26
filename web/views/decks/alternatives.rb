require_relative '../cards/columns/score'
require_relative '../cards/columns/tags'
require_relative '../cards/columns/cost'
require_relative '../cards/columns/identity'
require_relative '../cards/columns/creature_stats'
require_relative '../deck_cards/columns/name'

require_relative 'forms/add_card'
require_relative 'navigation/list'
require_relative 'navigation/show'
require_relative 'navigation/card'
require_relative 'navigation/alternatives'

module Web
  module Views
    module Decks
      class Alternatives < ::Html::Component
        def draw
          Layout.new(
            ::Html::Navigation.new(
              Navigation::List.new(breadcrumb: true),
              Navigation::Show.new(breadcrumb: true, deck: :deck),
              Navigation::Card.new(breadcrumb: true, card: :card),
              Navigation::Alternatives.new(
                breadcrumb: true, deck: :deck, current: true
              ),
              breadcrumb: true
            ),
            ::Html::Box.new(
              ::Html::Table.new(
                Cards::Columns::Score.new(sort: true),
                DeckCards::Columns::Name.new(sort: true, count: false),
                Cards::Columns::Tags.new,
                Cards::Columns::Cost.new(sort: true),
                Cards::Columns::Identity.new(sort: true),
                Cards::Columns::CreatureStats.new(sort: true),
                ::Html::Table::Column.new(
                  Forms::AddCard.new(
                    icon: true, inline: true, source: :_current_row,
                  ),
                  title: 'Actions'
                ),
                source: :cards
              ),
              title: 'Similar cards on your collection'
            ),
          )
        end
      end
    end
  end
end
