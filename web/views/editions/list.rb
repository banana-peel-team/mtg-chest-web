require_relative '../components/table'
require_relative '../components/table_column'
require_relative '../components/navigation'
require_relative '../components/box'

require_relative 'navigation/list'
require_relative 'columns/icon'
require_relative 'columns/name'

module Web
  module Views
    module Editions
      List = Layout.new([
        Components::Navigation.new([
          Navigation::List.new(breadcrumb: true, current: true),
        ], breadcrumb: true),
        Components::Box.new([
          Components::Table.new([
            Editions::Columns::Icon.new('Icon'),
            Editions::Columns::Name.new('Name'),
            Components::TableColumn.new('Code', source: :code),
          ], source: :editions)
        ], title: 'Editions'),
      ])
    end
  end
end
