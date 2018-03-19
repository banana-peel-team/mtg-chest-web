require 'web_helper'

RSpec.describe API::V1::Routes::Decks do
  let(:headers) {}
  let(:deck) { Fabricate(:deck) }

  subject(:request) do
    get("/api/v1/decks/#{deck.id}", {}, headers)
  end

  it_behaves_like 'a secure api endpoint'

  context 'when signed in' do
    let(:user) { Fabricate(:user) }
    let(:headers) { jwt_header(user) }

    context 'having a deck with 2 cards' do
      let(:deck) { Fabricate(:deck, user: user) }

      before do
        Fabricate.times(2, :deck_card, deck: deck)
      end

      it 'includes two cards' do
        request

        expect(json_response['cards'].count).to eq(2)
      end

      it_behaves_like "a deck_card" do
        before { request }

        subject { json_response['cards'].first }
      end
    end
  end
end
