RSpec.shared_examples 'a restricted route' do |data|
  context 'when not signed in' do
    let(:headers) { {} }

    it 'returns error'  do
      request

      expect(last_response.status).to eq(403)
    end
  end
end
