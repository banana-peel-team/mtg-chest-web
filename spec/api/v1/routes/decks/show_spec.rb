require 'web_helper'

RSpec.describe API::V1::Routes::Decks do
  let(:headers) {}
  let(:user) { Fabricate(:user) }
  let(:deck) { Fabricate(:deck, user: user) }

  subject(:request) do
    get("/api/v1/decks/#{deck.id}", {}, headers)
  end

  it_behaves_like 'a secure api endpoint'

  context 'when signed in' do
    let(:headers) { jwt_header(user) }

    subject(:cards) { json_response['cards'] }

    context 'having a deck with two copies of two cards' do
      let(:deck) { Fabricate(:deck, user: user, card_count: 4) }

      before do
        card1 = Fabricate(:card)
        card2 = Fabricate(:card)

        Fabricate.times(2, :deck_card, card: card1, deck: deck)
        Fabricate.times(2, :deck_card, card: card2, deck: deck)

        request
      end

      it_behaves_like 'a Deck' do
        subject { json_response }
      end

      it_behaves_like 'a DeckCard' do
        subject { json_response['cards'][0] }
      end

      it_behaves_like 'a DeckCard' do
        subject { json_response['cards'][1] }
      end

      it 'includes two cards' do
        expect(json_response).to include(
          'cards' => a_collection_containing_exactly(
            hash_including('card_count' => 2),
            hash_including('card_count' => 2),
          )
        )
      end
    end
  end
end
