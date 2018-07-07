require_relative '../components/table'
require_relative '../components/table_column'
require_relative '../components/navigation'
require_relative '../components/box'
require_relative '../components/box_title'

require_relative 'columns/name'
require_relative 'forms/delete_deck'
require_relative 'navigation/list'
require_relative 'navigation/new'

module Web
  module Views
    module Decks
      List = Layout.new([
        Components::Navigation.new([
          Decks::Navigation::List.new(breadcrumb: true, current: true),
        ], breadcrumb: true),
        Components::Box.new([
          Components::Navigation.new([
            Decks::Navigation::New.new,
          ]),
          Components::Table.new([
            Decks::Columns::Name.new(sort: true, count: :deck_cards),
            Components::TableColumn.new(
              title: 'Created',
              source: :deck_date,
              sort_column: 'deck_date',
              sort: true,
            ),
            Components::TableColumn.new([
              Forms::DeleteDeck.new(icon: true, inline: true),
            ], title: 'Actions'),
          ], source: :decks),
        ], title: 'Decks'),
      ])
    end
  end
end
