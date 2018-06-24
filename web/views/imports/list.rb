require_relative '../components/table'
require_relative '../components/table_column'
require_relative '../components/navigation'

require_relative 'navigation/list'
require_relative 'navigation/new'
require_relative 'columns/title'
require_relative 'forms/delete'

module Web
  module Views
    module Imports
      List = Layout.new([
        Components::Navigation.new([
          Navigation::List.new(breadcrumb: true, current: true),
        ], breadcrumb: true),

        Components::Box.new([
          Components::Navigation.new([
            Navigation::New.new(deck: :deck),
          ]),

          Components::Table.new([
            Columns::Title.new('Name'),
            Components::TableColumn.new('Created', source: :created_at),
            Components::TableColumn.new('Actions', [
              Forms::Delete.new(icon: true, inline: true)
            ])
          ], source: :imports),
        ], title: 'Imports'),
      ])
    end
  end
end
