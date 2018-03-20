require 'web_helper'

RSpec.describe API::V1::Routes::Collection do
  let(:headers) {}
  let(:user) { Fabricate(:user) }
  let(:user_printing) { Fabricate(:user_printing, user: user) }

  subject(:request) do
    get("/api/v1/collection/#{user_printing.printing.card_id}", {}, headers)
  end

  it_behaves_like 'a secure api endpoint'

  context 'when signed in' do
    let(:headers) { jwt_header(user) }

    before { request }

    it_behaves_like 'a Card' do
      subject { json_response['card'] }
    end

    it_behaves_like 'a UserPrinting' do
      subject { json_response['user_printings'].first }
    end
  end
end
