RSpec.shared_examples "a UserPrinting" do |data|
  it { is_expected.to include('user_printing_id' => Integer) }
  it { is_expected.to include('edition_code' => String) }
  it { is_expected.to include('edition_name' => String) }
  it { is_expected.to include('printing_added_date' => String) }
  it { is_expected.to include('printing_condition' => String) }
  it { is_expected.to include('printing_flavor' => String) }
  it { is_expected.to include('printing_foil') } # true | false
  it { is_expected.to include('printing_multiverse_id' => Integer) }
  it { is_expected.to include('printing_number' => String) }
  it { is_expected.to include('printing_rarity' => String) }
  it { is_expected.to include('import_id' => Integer) }
  it { is_expected.to include('import_name' => String) }

  it 'describes an existent user_printing' do
    user_printing = UserPrinting.find(id: subject['user_printing_id'])

    expect(user_printing).to be
  end
end
