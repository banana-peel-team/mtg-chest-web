require_relative '../components/navigation'
require_relative '../components/card'

require_relative 'navigation/list'
require_relative 'navigation/show'
require_relative 'navigation/edit'
require_relative 'navigation/add_cards'
require_relative 'forms/add_cards'

module Web
  module Views
    module Decks
      AddCards = Layout.new([
        Components::Navigation.new([
          Decks::Navigation::List.new(breadcrumb: true),
          Decks::Navigation::Show.new(breadcrumb: true, deck: :deck),
          Decks::Navigation::Edit.new(breadcrumb: true, deck: :deck),
          Decks::Navigation::AddCards.new(
            breadcrumb: true, deck: :deck, current: true
          ),
        ], breadcrumb: true),
        Components::Card.new([
          Forms::AddCards.new(name: 'deck'),
        ], title: 'Add cards'),
      ])
    end
  end
end
