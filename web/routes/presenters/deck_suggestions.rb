require_relative 'deck_cards'
require_relative 'paginated'

module Web
  module Routes
    module Presenters
      class DeckSuggestions < DeckCards
        include Paginated

        def initialize(user, deck, options)
          @user = user
          @deck = deck

          super(options)
        end

        private

        def dataset
          user = @params['all'] == '1' ? nil : @user

          @dataset ||= Queries::DeckCards.suggestions(
            user, @deck[:id]
          )
        end
      end
    end
  end
end
