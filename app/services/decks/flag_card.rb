module Services
  module Decks
    module FlagCard
      def self.flag_deck_card(deck_card)
        deck_card.update(is_flagged: true)
      end
    end
  end
end
