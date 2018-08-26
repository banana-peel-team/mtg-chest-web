require_relative '../cards/columns/score'
require_relative '../cards/columns/tags'
require_relative '../cards/columns/cost'
require_relative '../cards/columns/identity'
require_relative '../cards/columns/creature_stats'
require_relative '../cards/forms/identity_filter'
require_relative '../deck_cards/columns/name'
require_relative 'navigation/list'
require_relative 'navigation/show'

module Web
  module Views
    module Editions
      class Show < ::Html::Component
        def draw
          Layout.new(
            ::Html::Navigation.new(
              Navigation::List.new(breadcrumb: true),
              Navigation::Show.new(
                breadcrumb: true, edition: :edition, current: true
              ),
              breadcrumb: true
            ),
            ::Html::Box.new(
              ::Html::Box::Title.new(source: :edition, title: :name),
              ::Html::FilterForm.new(
                Cards::Forms::IdentityFilter.new,
                ::Html::Form::Submit.new(label: 'Refresh'),
                source: :printings
              ),
              ::Html::Table.new(
                Cards::Columns::Score.new(sort: true),
                DeckCards::Columns::Name.new(sort: true),
                Cards::Columns::Tags.new,
                Cards::Columns::Cost.new(sort: true),
                Cards::Columns::Identity.new(sort: true),
                Cards::Columns::CreatureStats.new(sort: true),
                source: :printings
              )
            )
          )
        end
      end
    end
  end
end
