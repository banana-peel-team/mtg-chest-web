RSpec.shared_examples "a user_printing" do |data|
  it_behaves_like "a printing"

  it 'describes an existent user_printing' do
    user_printing = UserPrinting.find(id: subject['user_printing_id'])

    expect(user_printing).to be
  end
end
