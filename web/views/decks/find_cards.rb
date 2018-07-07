require_relative '../components/form'
require_relative '../components/table'
require_relative '../components/forms/submit'
require_relative '../components/navigation'

require_relative '../deck_cards/columns/name'
require_relative '../cards/columns/score'
require_relative '../cards/columns/tags'
require_relative '../cards/columns/identity'
require_relative '../cards/columns/creature_stats'

require_relative 'forms/add_card'

require_relative 'suggestions_filter'
require_relative 'navigation/list'
require_relative 'navigation/show'
require_relative 'navigation/find_cards'

module Web
  module Views
    module Decks
      FindCards = Layout.new([
        Components::Navigation.new([
          Decks::Navigation::List.new(breadcrumb: true),
          Decks::Navigation::Show.new(breadcrumb: true, deck: :deck),
          Decks::Navigation::Edit.new(breadcrumb: true, deck: :deck),
          Decks::Navigation::FindCards.new(
            breadcrumb: true, deck: :deck, current: true
          ),
        ], breadcrumb: true),
        Components::Box.new([
          Components::Form.new([
            Decks::SuggestionsFilter.new(
              name: 'filter',
              source: :suggestions,
            ),
            Components::Forms::Submit.new(label: 'Refresh'),
          ], method: 'get'),
          Components::Table.new([
            Cards::Columns::Score.new(sort: true),
            DeckCards::Columns::Name.new(sort: true),
            Cards::Columns::Tags.new,
            Cards::Columns::Cost.new(sort: true),
            Cards::Columns::Identity.new(sort: true),
            Cards::Columns::CreatureStats.new(sort: true),
            Components::TableColumn.new([
              Forms::AddCard.new({
                icon: true, inline: true, source: :_current_row
              }),
            ], title: 'Actions'),
          ], source: :suggestions),
        ], title: 'Find cards for this deck'),
      ])
    end
  end
end
