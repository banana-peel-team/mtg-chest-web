require 'web_helper'

RSpec.describe do
  let(:path) {}
  let(:headers) { {} }

  describe 'GET' do
    let(:request) { get(path, {}, headers) }

    describe '/collection' do
      let(:path) { '/collection' }

      it_behaves_like 'a restricted route'

      context 'signed in' do
        let(:user) { Fabricate(:user) }
        let(:headers) { auth(user) }

        before do
          Fabricate(:user_printing, printing: Fabricate(:creature_printing),
                                    user: user)
          Fabricate(:user_printing, printing: Fabricate(:basic_land_printing),
                                    user: user)
        end

        it 'shows collection' do
          request

          expect(last_response.status).to eq(200)
        end
      end
    end
  end
end
