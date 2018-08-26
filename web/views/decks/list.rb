require_relative 'columns/name'
require_relative 'forms/delete_deck'
require_relative 'navigation/list'
require_relative 'navigation/new'

module Web
  module Views
    module Decks
      class List < ::Html::Component
        def draw
          Layout.new(
            ::Html::Navigation.new(
              Navigation::List.new(breadcrumb: true, current: true),
              breadcrumb: true
            ),
            ::Html::Box.new(
              ::Html::Navigation.new(
                Navigation::New.new,
              ),
              ::Html::Table.new(
                Decks::Columns::Name.new(sort: true, count: :deck_cards),
                ::Html::Table::Column.new(
                  title: 'Created',
                  source: :deck_date,
                  sort_column: 'deck_date',
                  sort: true,
                ),
                ::Html::Table::Column.new(
                  Forms::DeleteDeck.new(icon: true, inline: true),
                  title: 'Actions'
                ),
                source: :decks
              ),
              title: 'Decks'
            ),
          )
        end
      end
    end
  end
end
