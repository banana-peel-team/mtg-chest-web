require 'web_helper'

RSpec.describe do
  let(:path) {}
  let(:headers) { {} }

  describe 'GET' do
    let(:request) { get(path, {}, headers) }

    describe '/sessions/new' do
      let(:edition) { Fabricate(:edition) }
      let(:path) { '/sessions/new' }

      it 'shows session form' do
        request

        expect(last_response.status).to eq(200)
      end
    end
  end
end
