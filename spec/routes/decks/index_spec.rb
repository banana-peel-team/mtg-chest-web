require 'web_helper'

RSpec.describe do
  let(:path) {}
  let(:headers) { {} }

  describe 'GET' do
    let(:request) { get(path, {}, headers) }

    describe '/decks' do
      let(:path) { '/decks' }

      it_behaves_like 'a restricted route'

      context 'signed in' do
        let(:user) { Fabricate(:user) }
        let(:headers) { auth(user) }

        before do
          Fabricate(:deck, user: user)
          Fabricate(:deck, user: user)
        end

        it 'shows decks' do
          request

          expect(last_response.status).to eq(200)
        end
      end
    end
  end
end
