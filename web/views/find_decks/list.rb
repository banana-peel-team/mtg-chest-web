require_relative '../cards/forms/identity_filter'
require_relative 'columns/name'
require_relative 'columns/owned_deck_count'
require_relative 'navigation/list'

module Web
  module Views
    module FindDecks
      class List < ::Html::Component
        def draw
          Layout.new(
            ::Html::Navigation.new(
              Navigation::List.new(breadcrumb: true, current: true),
              breadcrumb: true
            ),
            ::Html::Box.new(
              ::Html::FilterForm.new(
                Cards::Forms::IdentityFilter.new(
                  namespace: 'filter',
                  source: :filters,
                ),
                ::Html::Form::Submit.new(label: 'Refresh'),
                source: :decks
              ),
              ::Html::Table.new(
                Columns::Name.new(sort: true, count: :card_count),
                Columns::OwnedDeckCount.new(sort: true),
                ::Html::Table::Column.new(
                  title: 'Format',
                  source: :event_format,
                  sort_column: 'format',
                  sort: true,
                ),
                ::Html::Table::Column.new(
                  title: 'Source',
                  source: :deck_database_name,
                  sort_column: 'source',
                  sort: true,
                ),
                source: :decks
              ),
              title: 'Find decks'
            ),
          )
        end
      end
    end
  end
end
