require 'web_helper'

RSpec.describe do
  let(:path) {}
  let(:headers) { {} }

  describe 'GET' do
    let(:request) { get(path, {}, headers) }

    describe '/decks/new' do
      let(:path) { "/decks/new" }

      it_behaves_like 'a restricted route'

      context 'signed in' do
        let(:user) { Fabricate(:user) }
        let(:headers) { auth(user) }

        it 'renders the form' do
          request

          expect(last_response.status).to eq(200)
        end
      end
    end
  end
end
