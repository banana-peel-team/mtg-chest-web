module Services
  module Decks
    module FromList
      def self.create(user, attrs)
        DB.transaction do
          deck = Deck.create(
            user_id: user[:id],
            name: attrs[:name],
            card_count: 0,
            created_at: Time.now.utc
          )

          attrs[:list].each do |line|
            add_card(deck, line)
          end

          count = deck.deck_cards_dataset.count
          deck.update(card_count: count)

          deck
        end
      end

      def self.add_card(deck, line)
        count, name = line.split(' ', 2)
        card = Card.where(name: name).first
        DeckCard.create_many(
          count.to_i,
          deck_id: deck[:id],
          card_id: card[:id],
          added_at: Time.now.utc,
        )
      end
      private_class_method :add_card
    end
  end
end
