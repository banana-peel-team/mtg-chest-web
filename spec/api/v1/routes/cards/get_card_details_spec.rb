require 'web_helper'

RSpec.describe API::V1::Routes::Cards do
  let(:headers) {}
  let(:card) { Fabricate(:card) }

  let(:request) do
    get("/api/v1/cards/#{card[:id]}")
  end

  subject(:details) { json_response['details'] }

  before { request }

  it_behaves_like 'a Card'
end
