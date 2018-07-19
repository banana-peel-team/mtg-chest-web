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
        import = Fabricate(:import)
        printing1 = Fabricate(:printing)
        printing2 = Fabricate(:printing)

        Fabricate(:user_printing, import: import,
                  printing: printing1, user: user)
        Fabricate(:user_printing, import: import,
                  printing: printing1, user: user)
        Fabricate(:user_printing, import: import,
                  printing: printing2, user: user)
        Fabricate(:user_printing, import: import,
                  printing: printing2, user: user)
      end

      before { request }
      subject(:cards) { json_response['items'] }

      it_behaves_like 'a CollectionCard' do
        subject { cards.first }
      end

      it 'includes two cards' do
        expect(json_response).to as_paginated(
          a_collection_containing_exactly(
            hash_including('card_count' => 2),
            hash_including('card_count' => 2),
          )
        )
      end
    end
  end
end
