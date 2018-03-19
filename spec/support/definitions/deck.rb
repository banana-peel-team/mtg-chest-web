RSpec.shared_examples "a deck" do |data|
  it { is_expected.to include('deck_id' => Integer) }
  it { is_expected.to include('deck_name' => String) }

  it 'describes an existent deck' do
    deck = Deck.find(id: subject['deck_id'])

    expect(deck).to be
    expect(deck.name).to eq(subject['deck_name'])
  end
end
