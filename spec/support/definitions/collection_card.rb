RSpec.shared_examples "a CollectionCard" do |data|
  it { is_expected.to include('card_color_identity' => [String]) }
  it { is_expected.to include('card_converted_mana_cost' => Float) }
  it { is_expected.to include('card_count' => Integer) }
  it { is_expected.to include('card_id' => Integer) }
  it { is_expected.to include('card_loyalty' => Integer) }
  it { is_expected.to include('card_mana_cost' => String) }
  it { is_expected.to include('card_name' => String) }
  it { is_expected.to include('card_power' => String) }
  it { is_expected.to include('card_toughness' => String) }

  it 'describes an existent card' do
    card = Card.find(id: subject['card_id'])

    expect(card).to be
    expect(card.name).to eq(subject['card_name'])
  end
end
