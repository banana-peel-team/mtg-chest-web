RSpec.shared_examples 'a card' do |data|
  it { is_expected.to include('card_id' => Integer) }
  it { is_expected.to include('card_name' => String) }

  it 'describes an existent card' do
    card = Card.find(id: subject['card_id'])

    expect(card).to be
    expect(card.name).to eq(subject['card_name'])
  end
end
