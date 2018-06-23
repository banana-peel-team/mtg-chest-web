require 'web_helper'

RSpec.describe do
  let(:path) {}
  let(:headers) { {} }

  describe 'GET' do
    let(:request) { get(path, {}, headers) }

    describe '/decks/:id/find-cards' do
      let(:deck) { Fabricate(:deck) }
      let(:path) { "/decks/#{deck.id}/find-cards" }

      it_behaves_like 'a restricted route'

      context 'signed in' do
        let(:user) { Fabricate(:user) }
        let(:deck) { Fabricate(:deck, user: user) }
        let(:headers) { auth(user) }

        it 'shows cards' do
          request

          expect(last_response.status).to eq(200)
        end
      end
    end
  end
end
