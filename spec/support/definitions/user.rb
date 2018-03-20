RSpec.shared_examples "a User" do |data|
  it { is_expected.to include('user_id' => Integer) }
  it { is_expected.to include('username' => String) }

  it 'does not include extra information' do
    expect(subject.keys).to match_array(
      ['user_id', 'username']
    )
  end

  it 'describes an existent user' do
    user = User.find(id: subject['user_id'])

    expect(user).to be
    expect(user.username).to eq(subject['username'])
  end
end
