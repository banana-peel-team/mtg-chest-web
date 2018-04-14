require 'web_helper'

RSpec.describe do
  let(:path) {}
  let(:headers) { {} }

  describe 'DELETE' do
    let(:request) { post(path, { _method: :delete }, headers) }

    describe '/collection/imports/:id' do
      let(:import) { Fabricate(:import) }
      let(:path) { "/collection/imports/#{import.id}" }

      it_behaves_like 'a restricted route'

      context 'signed in' do
        let(:user) { Fabricate(:user) }
        let!(:import) { Fabricate(:import, user: user) }
        let(:headers) { auth(user) }

        before do
          Fabricate(:user_printing, printing: Fabricate(:creature_printing),
                                    import: import,
                                    user: user)
          Fabricate(:user_printing, printing: Fabricate(:basic_land_printing),
                                    import: import,
                                    user: user)
        end

        it 'deletes the import' do
          expect {
            request
          }.to change(Import, :count).by(-1)
        end

        it 'redirects' do
          request

          expect(last_response.status).to eq(302)
        end
      end
    end
  end
end
