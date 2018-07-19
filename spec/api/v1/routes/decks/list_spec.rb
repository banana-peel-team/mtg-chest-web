require 'web_helper'

RSpec.describe API::V1::Routes::Decks do
  let(:headers) {}

  subject(:request) do
    get('/api/v1/decks', {}, headers)
  end

  it_behaves_like 'a secure api endpoint'

  context 'when signed in' do
    let(:user) { Fabricate(:user) }
    let(:headers) { jwt_header(user) }

    context 'having two decks' do
      let!(:deck1) { Fabricate(:deck, user: user) }
      let!(:deck2) { Fabricate(:deck, user: user) }

      before { request }

      it_behaves_like 'a Deck' do
        let(:deck) { deck1 }

        subject { json_response['items'][0] }
      end

      it_behaves_like 'a Deck' do
        let(:deck) { deck2 }

        subject { json_response['items'][1] }
      end
    end
  end
end
