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

    context 'having two copies of two cards imported' do
      before do
        printing1 = Fabricate(:printing)
        printing2 = Fabricate(:printing)

        Fabricate(:user_printing, printing: printing1, user: user)
        Fabricate(:user_printing, printing: printing2,user: user)
      end

      before { request }
      subject(:cards) { json_response['cards'] }

      it 'includes two cards' do
        expect(json_response['cards'].count).to eq(2)
      end

      it_behaves_like "a CollectionCard" do
        subject { cards.first }
      end
    end
  end
end
