RSpec.shared_examples "a Deck" do |data|
  it 'includes deck information' do
    is_expected.to include(
      'deck_id' => Integer,
      'deck_name' => String,
      'deck_cards' => Integer,
      'deck_date' => String,
    )
  end

  it 'describes an existent deck' do
    expect(deck.name).to eq(subject['deck_name'])
    expect(deck.deck_cards.count).to eq(subject['deck_cards'])
  end
end
