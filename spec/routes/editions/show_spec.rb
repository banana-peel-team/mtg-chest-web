require 'web_helper'

RSpec.describe do
  let(:path) {}
  let(:headers) { {} }

  describe 'GET' do
    let(:request) { get(path, {}, headers) }

    describe '/editions/:code' do
      let(:edition) { Fabricate(:edition) }
      let(:path) { "/editions/#{edition.code}" }

      before do
        Fabricate(:printing, edition: edition)
        Fabricate(:creature_printing, edition: edition)
        Fabricate(:basic_land_printing, edition: edition)
      end

      it 'lists edition printings' do
        request

        expect(last_response.status).to eq(200)
      end
    end
  end
end
