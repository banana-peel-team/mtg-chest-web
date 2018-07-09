module Web
  module Routes
    class DeckCards < Web::Server
      define do
        require_login!

        on(':deck_card_id') do |deck_card_id|
          deck_card = DeckCard.first(id: deck_card_id)
          not_found! unless deck_card
          deck = deck_card.deck
          not_found! unless deck[:user_id] == current_user[:id]

          on(post, root, param('slot')) do |slot|
            Services::Decks::MoveCard.to_slot(deck_card, slot)

            redirect_back("/decks/#{deck[:id]}/edit")
          end

          on(post, root, param('status')) do |status|
            case status
              when 'flagged'
                Services::Decks::FlagCard.flag_deck_card(deck_card)
              when 'unlinked'
                Services::Decks::UnlinkCard.unlink_deck_card(deck_card)
              when 'removed'
                Services::Decks::DeleteCard.delete_deck_card(deck_card)
            end

            redirect_back("/decks/#{deck[:id]}/edit")
          end

          on(delete, root) do
            Services::Decks::DeleteCard.delete_deck_card(deck_card)
            redirect_back("/decks/#{deck[:id]}/edit")
          end

          on(post, 'flag') do
            Services::Decks::FlagCard.flag_deck_card(deck_card)

            redirect_back("/decks/#{deck[:id]}/edit")
          end

          on(delete, 'unlink') do
            Services::Decks::UnlinkCard.unlink_deck_card(deck_card)

            redirect_back("/decks/#{deck[:id]}/edit")
          end
        end
      end
    end
  end
end
