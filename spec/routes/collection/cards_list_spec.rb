require 'web_helper'

RSpec.describe do
  let(:path) {}
  let(:headers) { {} }

  describe 'GET' do
    let(:request) { get(path, {}, headers) }

    describe '/collection/imports/:id/list' do
      let(:import) { Fabricate(:import) }
      let(:path) { "/collection/imports/#{import.id}/list" }

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

        it 'shows import cards' do
          request

          expect(last_response.status).to eq(200)
        end
      end
    end
  end
end
