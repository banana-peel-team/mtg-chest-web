RSpec.shared_examples "a deck_card" do |data|
  it_behaves_like 'a card'

  it { is_expected.to include('deck_card_id' => Integer) }

  it 'describes an existent deck_card' do
    deck_card = DeckCard.find(id: subject['deck_card_id'])

    expect(deck_card).to be
    expect(deck_card.card.name).to eq(subject['card_name'])
  end
end
