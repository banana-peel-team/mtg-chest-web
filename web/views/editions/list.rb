require_relative 'navigation/list'
require_relative 'columns/icon'
require_relative 'columns/name'

module Web
  module Views
    module Editions
      class List < ::Html::Component
        def draw
          Layout.new(
            ::Html::Navigation.new(
              Navigation::List.new(breadcrumb: true, current: true),
              breadcrumb: true
            ),
            ::Html::Box.new(
              ::Html::Table.new(
                Editions::Columns::Icon.new,
                Editions::Columns::Name.new(sort: true),
                ::Html::Table::Column.new(
                  title: 'Date',
                  source: :edition_date,
                  sort: true,
                  format: '%F',
                  sort_column: 'edition_date',
                ),
                ::Html::Table::Column.new(
                  title: 'Code',
                  source: :edition_code,
                  sort: true,
                  sort_column: 'edition_code',
                ),
                source: :editions
              ),
              title: 'Editions'
            ),
          )
        end
      end
    end
  end
end
