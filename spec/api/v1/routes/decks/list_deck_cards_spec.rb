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
      before do
        card1 = Fabricate(:card)
        card2 = Fabricate(:card)

        Fabricate.times(2, :deck_card, card: card1, deck: deck)
        Fabricate.times(2, :deck_card, card: card2, deck: deck)

        request
      end

      it 'includes two cards' do
        expect(cards.count).to eq(2)
      end

      it_behaves_like "a CollectionCard" do
        subject { cards.first }
      end
    end
  end
end
