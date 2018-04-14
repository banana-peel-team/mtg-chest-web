require 'web_helper'

RSpec.describe do
  let(:path) {}
  let(:headers) { {} }

  describe 'GET' do
    let(:request) { get(path, {}, headers) }

    describe '/editions' do
      let(:path) { '/editions' }

      before do
        Fabricate(:edition)
      end

      it 'lists editions' do
        request

        expect(last_response.status).to eq(200)
      end
    end
  end
end
