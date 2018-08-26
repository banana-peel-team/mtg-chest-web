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
      class EditCards < ::Html::Component
        def draw
          Layout.new(
            ::Html::Navigation.new(
              Navigation::List.new(breadcrumb: true),
              Navigation::Show.new(breadcrumb: true, deck: :deck),
              Navigation::Edit.new(
                breadcrumb: true, deck: :deck, current: true
              ),
              breadcrumb: true
            ),
            ::Html::Box.new(
              ::Html::Navigation.new(
                Navigation::FindCards.new(deck: :deck),
                Navigation::LinkCards.new(deck: :deck),
                Navigation::AddCards.new(deck: :deck),
              ),
              ::Html::Table.new(
                Cards::Columns::Score.new(sort: true),
                DeckCards::Columns::Name.new(sort: true),
                Cards::Columns::Tags.new,
                Cards::Columns::Cost.new(sort: true),
                Cards::Columns::Identity.new(sort: true),
                Cards::Columns::CreatureStats.new(sort: true),
                ::Html::Table::Column.new(
                  Forms::EditDeckCard.new(
                    source: :_current_row, icon: true, inline: true
                  ),
                  title: 'Actions'
                ),
                source: :cards
              ),
              title: 'Edit cards'
            ),
            ::Html::Box.new(
              ::Html::Table.new(
                Cards::Columns::Score.new(sort: true),
                DeckCards::Columns::Name.new(sort: true),
                Cards::Columns::Tags.new,
                Cards::Columns::Cost.new(sort: true),
                Cards::Columns::Identity.new(sort: true),
                Cards::Columns::CreatureStats.new(sort: true),
                ::Html::Table::Column.new(
                  Forms::EditDeckCard.new(
                    flag: false, source: :_current_row, icon: true, inline: true
                  ),
                  title: 'Actions'
                ),
                source: :scratchpad
              ),
              title: 'Scratchpad'
            ),
          )
        end
      end
    end
  end
end
