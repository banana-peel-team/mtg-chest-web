RSpec.shared_examples "a Deck" do |data|
  it { is_expected.to include('deck_id' => Integer) }
  it { is_expected.to include('deck_name' => String) }
  it { is_expected.to include('card_count' => Integer) }
  it { is_expected.to include('deck_date' => String) }

  it 'describes an existent deck' do
    deck = Deck.find(id: subject['deck_id'])

    expect(deck).to be
    expect(deck.name).to eq(subject['deck_name'])
    expect(deck.deck_cards.count).to eq(subject['card_count'])
  end
end
