module Web
  module Routes
    module Presenters
      class EditionCards
        attr_reader :edition
        attr_reader :user

        def initialize(edition, user)
          @edition = edition
          @user = user
        end

        def rated_decks
          @rated_decks ||= DeckDatabase.select(:key, :name, :max_score).all
        end

        def printings
          Queries::EditionPrintings.for_edition(edition[:code], user).all
        end
      end
    end
  end
end
