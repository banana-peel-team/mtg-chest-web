require_relative '../cards/forms/identity_filter'
require_relative 'columns/name'
require_relative 'columns/owned_deck_count'
require_relative 'navigation/list'

module Web
  module Views
    module FindDecks
      List = Layout.new([
        Components::Navigation.new([
          Navigation::List.new(breadcrumb: true, current: true),
        ], breadcrumb: true),
        Components::Box.new([
          Components::Form.new([
            Cards::Forms::IdentityFilter.new(
              name: 'filter',
              source: :decks,
            ),
            Components::Forms::Submit.new(label: 'Refresh'),
          ], method: 'get'),
          Components::Table.new([
            Columns::Name.new(sort: true, count: :required_count),
            Columns::OwnedDeckCount.new(
              sort: true,
            ),
            Components::TableColumn.new(
              title: 'Format',
              source: :event_format,
              sort_column: 'format',
              sort: true,
            ),
            Components::TableColumn.new(
              title: 'Source',
              source: :deck_database_name,
              sort_column: 'source',
              sort: true,
            ),
          ], source: :decks),
        ], title: 'Find decks'),
      ])
    end
  end
end
