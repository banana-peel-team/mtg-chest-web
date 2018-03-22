require 'web_helper'

RSpec.describe API::V1::Routes::Decks do
  let(:headers) {}
  let(:user) { Fabricate(:user) }
  let(:deck) { Fabricate(:deck, user: user) }
  let(:deck_card) { Fabricate(:deck_card, deck: deck) }

  subject(:request) do
    get("/api/v1/decks/#{deck.id}/cards/#{deck_card.card_id}", {}, headers)
  end

  it_behaves_like 'a secure api endpoint'

  context 'when signed in' do
    let(:headers) { jwt_header(user) }

    subject(:details) { json_response['details'] }
    before { request }

    it_behaves_like 'a Card'
    it_behaves_like 'a CollectionCard'
  end
end
