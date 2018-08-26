require_relative '../cards/columns/cost'
require_relative '../cards/columns/creature_stats'
require_relative '../cards/columns/identity'
require_relative '../cards/columns/score'
require_relative '../cards/columns/tags'
require_relative '../cards/forms/identity_filter'

require_relative 'columns/name'
require_relative 'navigation/database'

module Web
  module Views
    module Cards
      class Database < ::Html::Component
        def draw
          Layout.new(
            ::Html::Navigation.new(
              Navigation::Database.new(breadcrumb: true, current: true),
              breadcrumb: true
            ),
            ::Html::Box.new(
              ::Html::Box::Title.new(source: :edition, title: :name),
              ::Html::FilterForm.new(
                Forms::IdentityFilter.new,
                ::Html::Form::Submit.new(label: 'Refresh'),
                source: :printings
              ),
              ::Html::Table.new(
                Columns::Score.new(sort: true),
                Columns::Name.new(sort: true),
                Columns::Tags.new,
                Columns::Cost.new(sort: true),
                Columns::Identity.new(sort: true),
                Columns::CreatureStats.new(sort: true),
                source: :printings
              )
            )
          )
        end
      end
    end
  end
end
