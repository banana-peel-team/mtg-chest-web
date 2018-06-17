module Services
  module Decks
    module AddCard
      extend self

      # Adds a card into a deck
      # TODO: refactor, this is just working.
      def perform(deck, slot, card)
        user_printing_id = card[:user_printing_id]

        existing = existing_cards(deck[:id], card[:card_id], user_printing_id)

        if existing.any?
          if user_printing_id
            same = existing.find do |card|
              card[:user_printing_id] == user_printing_id
            end

            if same
              if same[:slot] != slot
                same.update(slot: slot)

                if slot == 'deck'
                  deck.update(card_count: Sequel.+(:card_count, 1))
                end
              end
            else
              update = existing.find do |card|
                !card[:user_printing_id] && card[:slot] == slot
              end

              if update
                update.update(user_printing_id: user_printing_id)
              else
                move =
                  if slot == 'deck'
                    existing.find do |card|
                      !card[:user_printing_id] && card[:slot] == 'scratchpad'
                    end
                  else
                    nil
                  end

                if move
                  move.update(
                    slot: slot,
                    user_printing_id: user_printing_id
                  )
                else
                  DeckCard.create(
                    deck_id: deck[:id],
                    slot: slot,
                    card_id: card[:card_id],
                    user_printing_id: user_printing_id,
                    added_at: Time.now.utc,
                  )
                end

                if slot == 'deck'
                  deck.update(card_count: Sequel.+(:card_count, 1))
                end
              end
            end
          else
            if slot == 'deck'
              change = existing.find do |card|
                !card[:user_printing_id] && card[:slot] == 'scratchpad'
              end

              if change
                change.update(slot: 'deck')
              else
                DeckCard.create(
                  deck_id: deck[:id],
                  slot: slot,
                  card_id: card[:card_id],
                  added_at: Time.now.utc,
                )

                deck.update(card_count: Sequel.+(:card_count, 1))
              end
            else
              DeckCard.create(
                deck_id: deck[:id],
                slot: slot,
                card_id: card[:card_id],
                added_at: Time.now.utc,
              )
            end
          end
        else
          DeckCard.create(
            deck_id: deck[:id],
            slot: slot,
            card_id: card[:card_id],
            user_printing_id: card[:user_printing_id],
            added_at: Time.now.utc,
          )

          if slot == 'deck'
            deck.update(card_count: Sequel.+(:card_count, 1))
          end
        end
      end

      private

      def existing_cards(deck_id, card_id, user_printing_id)
        existing = DeckCard
          .select(:id, :user_printing_id, :slot)
          .where(card_id: card_id, deck_id: deck_id)
          .where do |ds|
            (ds.user_printing_id =~ user_printing_id) |
              (ds.user_printing_id =~ nil)
          end
          .all
      end
    end
  end
end
