require 'web_helper'

RSpec.describe API::V1::Routes::Collection do
  let(:headers) {}

  subject(:request) do
    get('/api/v1/collection', {}, headers)
  end

  it_behaves_like 'a secure api endpoint'

  context 'when signed in' do
    let(:user) { Fabricate(:user) }
    let(:headers) { jwt_header(user) }

    context 'having two cards imported' do
      before do
        Fabricate(:user_printing, user: user)
        Fabricate(:user_printing, user: user)
      end

      it 'includes two cards' do
        request

        expect(json_response['cards'].count).to eq(2)
      end

      it_behaves_like "a user_printing" do
        before { request }

        subject { json_response['cards'].first }
      end
    end
  end
end
