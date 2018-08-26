require_relative '../deck_cards/columns/name'
require_relative '../cards/columns/score'
require_relative '../cards/columns/tags'
require_relative '../cards/columns/identity'
require_relative '../cards/columns/creature_stats'

require_relative 'forms/add_card'
require_relative 'forms/suggestions_filter'
require_relative 'navigation/list'
require_relative 'navigation/show'
require_relative 'navigation/find_cards'

module Web
  module Views
    module Decks
      class FindCards < ::Html::Component
        def draw
          Layout.new(
            ::Html::Navigation.new(
              Navigation::List.new(breadcrumb: true),
              Navigation::Show.new(breadcrumb: true, deck: :deck),
              Navigation::Edit.new(breadcrumb: true, deck: :deck),
              Navigation::FindCards.new(
                breadcrumb: true, deck: :deck, current: true
              ),
              breadcrumb: true
            ),
            ::Html::Box.new(
              ::Html::FilterForm.new(
                Forms::SuggestionsFilter.new(
                  namespace: 'filter',
                  source: :filters,
                ),
                ::Html::Form::Submit.new(label: 'Refresh'),
                source: :suggestions
              ),
              ::Html::Table.new(
                Cards::Columns::Score.new(sort: true),
                DeckCards::Columns::Name.new(sort: true),
                Cards::Columns::Tags.new,
                Cards::Columns::Cost.new(sort: true),
                Cards::Columns::Identity.new(sort: true),
                Cards::Columns::CreatureStats.new(sort: true),
                ::Html::Table::Column.new(
                  Forms::AddCard.new(
                    icon: true, inline: true, source: :_current_row
                  ),
                  title: 'Actions'
                ),
                source: :suggestions
              ),
              title: 'Find cards for this deck'
            ),
          )
        end
      end
    end
  end
end
