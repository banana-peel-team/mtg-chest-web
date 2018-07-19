RSpec::Matchers.define :as_user do |expected|
  match do |actual|
    expect(actual).to include(
      'user_id' => Integer,
      'username' => String,
    )

    expect(actual.keys).to match_array(
      ['user_id', 'username']
    )

    user = User.find(id: actual['user_id'])

    expect(user).to be
    expect(user.username).to eq(actual['username'])
  end
end
