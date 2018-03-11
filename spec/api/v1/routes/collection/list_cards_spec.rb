require 'web_helper'

RSpec.describe API::V1::Routes::Collection do
  let(:headers) {}

  subject(:request) do
    get('/api/v1/collection', {}, headers)
  end

  context 'with invalid credentials' do
    let(:headers) { {} }

    it 'returns error'  do
      request

      expect(last_response.status).to eq(401)
    end
  end

  context 'when signed in' do
    let(:user) { Fabricate(:user) }
    let(:headers) { jwt_header(user) }

    it 'returns ok'  do
      request
      last_response.body

      expect(last_response.status).to eq(200)
    end

    context 'having two cards imported' do
      before do
        Fabricate(:user_printing, user: user)
        Fabricate(:user_printing, user: user)
      end

      it 'includes two cards' do
        request

        expect(json_response['cards'].count).to eq(2)
      end

      it 'includes cards information' do
        request

        cards = json_response['cards']
        names = cards.map { |card| card[:name] }
        expect(names).to be_an(Array)
      end
    end
  end
end
