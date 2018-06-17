module Web
  module Routes
    class DeckCards < Web::Server
      define do
        require_login!

        on(':deck_card_id') do |deck_card_id|
          deck_card = DeckCard.first(id: deck_card_id)
          not_found! unless deck_card

          on(delete, root) do
            Services::Decks::DeleteCard.delete_deck_card(deck_card)
            deck = deck_card.deck
            redirect_back("/decks/#{deck[:id]}/edit")
          end

          on(delete, 'unlink') do
            Services::Decks::UnlinkCard.unlink_deck_card(deck_card)
            deck = deck_card.deck

            redirect_back("/decks/#{deck[:id]}/edit")
          end
        end
      end
    end
  end
end
