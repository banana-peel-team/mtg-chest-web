require 'web_helper'

RSpec.describe do
  let(:path) {}
  let(:headers) { {} }

  describe 'GET' do
    let(:request) { get(path, {}, headers) }

    describe '/collection/imports/:id/deckbox' do
      let(:import) { Fabricate(:import) }
      let(:path) { "/collection/imports/#{import.id}/deckbox" }

      it_behaves_like 'a restricted route'

      context 'signed in' do
        let(:user) { Fabricate(:user) }
        let(:import) { Fabricate(:import, user: user) }
        let(:headers) { auth(user) }

        before do
          Fabricate(:user_printing, printing: Fabricate(:creature_printing),
                                    import: import,
                                    user: user)
          Fabricate(:user_printing, printing: Fabricate(:basic_land_printing),
                                    import: import,
                                    user: user)
        end

        it 'responds ok' do
          request

          expect(last_response.status).to eq(200)
        end

        it 'sends export file' do
          request

          expect(last_response['Content-Disposition'])
            .to start_with('attachment;')
        end
      end
    end
  end
end
