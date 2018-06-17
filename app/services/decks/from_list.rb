module Services
  module Decks
    module FromList
      def self.add_cards(deck, attrs)
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

      def self.create(user, attrs)
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

      def self.add_card(deck, line, slot)
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
      private_class_method :add_card
    end
  end
end
