require 'web_helper'

RSpec.describe do
  let(:path) {}
  let(:headers) { {} }

  describe 'GET' do
    let(:request) { get(path, {}, headers) }

    describe '/collection/imports' do
      let(:path) { '/collection/imports' }

      it_behaves_like 'a restricted route'

      context 'signed in' do
        let(:user) { Fabricate(:user) }
        let(:headers) { auth(user) }

        before do
          Fabricate(:import, user: user)
        end

        it 'list imports' do
          request

          expect(last_response.status).to eq(200)
        end
      end
    end
  end
end
