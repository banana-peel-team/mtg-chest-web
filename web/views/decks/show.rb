require_relative 'navigation/find_cards'
require_relative 'navigation/list'
require_relative 'navigation/show'
require_relative 'navigation/card_list'
require_relative 'navigation/edit'
require_relative 'columns/deck_card_actions'

module Web
  module Views
    module Decks
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
              ::Html::Navigation.new(
                Navigation::CardList.new(deck: :deck),
                Navigation::Edit.new(deck: :deck),
              ),
              ::Html::Table.new(
                Cards::Columns::Score.new(sort: true),
                DeckCards::Columns::Name.new(sort: true),
                Cards::Columns::Tags.new,
                Cards::Columns::Cost.new(sort: true),
                Cards::Columns::Identity.new(sort: true),
                Cards::Columns::CreatureStats.new(sort: true),
                Columns::DeckCardActions.new,
                source: :cards
              ),
            ),
          )
        end
      end
    end
  end
end
