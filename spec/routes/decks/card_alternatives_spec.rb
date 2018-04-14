require 'web_helper'

RSpec.describe do
  let(:path) {}
  let(:headers) { {} }

  describe 'GET' do
    let(:request) { get(path, {}, headers) }

    describe '/decks/:id/cards/:card-id/alternatives' do
      let(:deck) { Fabricate(:deck) }
      let(:deck_card) { Fabricate(:deck_card) }
      let(:path) do
        "/decks/#{deck.id}/cards/#{deck_card.card_id}/alternatives"
      end

      it_behaves_like 'a restricted route'

      context 'signed in' do
        let(:user) { Fabricate(:user) }
        let(:deck) { Fabricate(:deck, user: user) }
        let(:headers) { auth(user) }

        before do
          Fabricate(:deck_card, card: Fabricate(:creature_card),
                                deck: deck)
          Fabricate(:deck_card, card: Fabricate(:basic_land_card),
                                deck: deck)
        end

        it 'shows alternative cards' do
          request

          expect(last_response.status).to eq(200)
        end
      end
    end
  end
end
