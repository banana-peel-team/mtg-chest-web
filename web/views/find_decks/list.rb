require_relative '../components/box'
require_relative '../components/box_title'
require_relative '../components/navigation'
require_relative '../components/table'
require_relative '../components/table_column'

require_relative 'columns/name'
require_relative 'navigation/list'

module Web
  module Views
    module FindDecks
      List = Layout.new([
        Components::Navigation.new([
          Navigation::List.new(breadcrumb: true, current: true),
        ], breadcrumb: true),
        Components::Box.new([
          Components::Table.new([
            Columns::Name.new(sort: true, count: :required_count),
            Components::TableColumn.new(
              title: 'Owned cards',
              source: :owned_count,
              format: '%d',
              sort_column: 'count',
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
