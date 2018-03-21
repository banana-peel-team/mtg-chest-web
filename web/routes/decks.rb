module Web
  module Routes
    class Decks < Web::Server
      define do
        on(root) do
          on(get) do
            decks = Queries::Decks.for_user(current_user)

            render('decks/index', decks: decks)
          end
        end

        on(post, 'import-list', param('deck')) do |params|
          deck = Services::Decks::FromList.create(current_user, {
            name: params['name'],
            list: params['list'].split(/[\n\r]+/)
          })

          redirect_to("/decks/#{deck[:id]}")
        end

        on('new') do
          on(get, root) do
            render('decks/new')
          end
        end

        on(':id') do |id|
          deck = Deck.where(id: id).first
          not_found! unless deck

          on(delete, root) do
            Services::Decks::Delete.deck(id)
            redirect_to('/collection/imports')
          end

          on(get, root) do
            cards = Queries::DeckCards.for_deck(current_user, deck[:id])

            render('decks/show', deck: deck, cards: cards)
          end

          on(get, 'list') do
            cards = Queries::DeckCards.for_deck(current_user, deck[:id])

            render('cards/list', cards: cards)
          end

          on('cards') do
            on(get, ':card_id') do |card_id|
              card = Queries::Cards.card(card_id)

              cards = Queries::DeckCards.alternatives(
                current_user, deck[:id], card
              )

              render('decks/card', deck: deck, card: card,
                     alternatives: cards)
            end
          end
        end
      end
    end
  end
end
