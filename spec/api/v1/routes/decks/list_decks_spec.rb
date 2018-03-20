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
      before do
        Fabricate(:deck, user: user)
        Fabricate(:deck, user: user)
      end

      before { request }

      it 'includes two decks' do
        expect(json_response['decks'].count).to eq(2)
      end

      it_behaves_like "a Deck" do
        subject { json_response['decks'].first }
      end
    end
  end
end
