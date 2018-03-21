RSpec.shared_examples "a secure api endpoint" do |data|
  context 'when not signed in' do
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

      expect(last_response.status).to eq(200)
    end
  end
end
