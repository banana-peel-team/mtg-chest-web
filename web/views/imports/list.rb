require_relative 'navigation/list'
require_relative 'navigation/new'
require_relative 'columns/title'
require_relative 'forms/delete'

module Web
  module Views
    module Imports
      class List < ::Html::Component
        def draw
          Layout.new(
            ::Html::Navigation.new(
              Navigation::List.new(breadcrumb: true, current: true),
              breadcrumb: true
            ),

            ::Html::Box.new(
              ::Html::Navigation.new(
                Navigation::New.new(deck: :deck),
              ),

              ::Html::Table.new(
                Columns::Title.new,
                ::Html::Table::Column.new(
                  title: 'Created', source: :created_at
                ),
                ::Html::Table::Column.new(
                  Forms::Delete.new(icon: true, inline: true),
                  title: 'Actions'
                ),
                source: :imports
              ),
              title: 'Imports'
            ),
          )
        end
      end
    end
  end
end
