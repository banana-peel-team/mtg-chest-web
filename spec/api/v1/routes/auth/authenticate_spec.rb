require 'web_helper'

RSpec.describe API::V1::Routes::Auth do
  let(:params) {}

  subject(:request) do
    post_json('api/v1/auth', params)
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

    before { request }

    let(:params) do
      { username: user.username, password: password }
    end

    it 'returns ok'  do
      expect(last_response.status).to eq(200)
    end

    it 'includes authorization header' do
      expect(last_response.headers).to include('AUTHORIZATION')
    end

    it 'produces a validable token' do
      token = last_response.headers['AUTHORIZATION']
      token = token.gsub(/^Bearer /, '')

      expect {
        JWT.decode(token, jwt_secret, true)
      }.to_not raise_error

      expect {
        JWT.decode(token, "#{jwt_secret}-invalid", true)
      }.to raise_error(JWT::VerificationError)
    end

    it 'returns the user' do
      expect(json_response).to include(
        'user' => as_user
      )
    end
  end
end
