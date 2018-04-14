require 'web_helper'

RSpec.describe do
  let(:path) {}
  let(:headers) { {} }

  describe 'GET' do
    let(:request) { get(path, {}, headers) }

    describe '/editions/:code/cards/:card-id' do
      let(:printing) { Fabricate(:printing) }
      let(:path) do
        "/editions/#{printing.edition.code}/cards/#{printing.card_id}"
      end

      it 'shows printing details' do
        request

        expect(last_response.status).to eq(200)
      end
    end
  end
end
