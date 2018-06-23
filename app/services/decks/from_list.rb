module Services
  module Decks
    module FromList
      extend self

      def add_cards(deck, attrs)
        DB.transaction do
          slot = attrs[:scratchpad] ? 'scratchpad' : 'deck'

          attrs[:list].each do |line|
            add_card(deck, line, slot)
          end

          if slot == 'deck'
            deck.update_card_count
          end
        end
      end

      def create(user, attrs)
        DB.transaction do
          deck = Deck.create(
            user_id: user[:id],
            name: attrs[:name],
            card_count: 0,
            created_at: Time.now.utc
          )

          attrs[:list].each do |line|
            add_card(deck, line, 'deck')
          end

          deck.update_card_count

          deck
        end
      end

      private

      def add_card(deck, line, slot)
        count, name = line.split(' ', 2)
        card = Card.where(name: name).first
        DeckCard.create_many(
          count.to_i,
          deck_id: deck[:id],
          card_id: card[:id],
          added_at: Time.now.utc,
          slot: slot,
        )
      end
    end
  end
end
