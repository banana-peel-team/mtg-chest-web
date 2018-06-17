require_relative 'paginated'

module Web
  module Routes
    module Presenters
      class ShowCollection
        include Paginated

        attr_reader :user

        def initialize(user, options = {})
          @user = user

          super(options)
        end

        def rated_decks
          @rated_decks ||= DeckDatabase.select(:key, :name, :max_score).all
        end

        private

        def dataset
          Queries::CollectionCards.full_for_user(user)
        end
      end
    end
  end
end
