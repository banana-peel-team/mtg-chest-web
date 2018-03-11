require 'web_helper'

RSpec.describe API::V1::Routes::Auth do
  let(:params) {}

  subject(:request) do
    post('/api/v1/auth', params)
  end

  context 'with invalid credentials' do
    let(:params) do
      { username: '', password: '' }
    end

    it 'returns error'  do
      request

      expect(last_response.status).to eq(403)
    end
  end

  context 'with valid credentials' do
    let(:password) { 'test-password' }
    let(:user) { Fabricate(:user, password: password) }

    let(:params) do
      { username: user.username, password: password }
    end

    it 'returns ok'  do
      request

      expect(last_response.status).to eq(200)
    end

    it 'includes authorization header' do
      request

      expect(last_response.headers).to include('HTTP_AUTHORIZATION')
    end

    it 'produces a validable token' do
      request
      token = last_response.headers['HTTP_AUTHORIZATION']

      expect {
        JWT.decode(token, jwt_secret, true)
      }.to_not raise_error

      expect {
        JWT.decode(token, "#{jwt_secret}-invalid", true)
      }.to raise_error(JWT::VerificationError)
    end

    context 'response body' do
      subject do
        request

        last_response.body
      end

      it { is_expected.to include('id', 'username') }
    end
  end
end
