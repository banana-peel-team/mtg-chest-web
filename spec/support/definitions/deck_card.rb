RSpec.shared_examples "a DeckCard" do |data|
  it 'includes card information' do
    is_expected.to include(
      'card_color_identity' => [String],
      'card_colors' => [String],
      'card_converted_mana_cost' => Float,
      'card_count' => Integer,
      'card_id' => Integer,
      'card_layout' => String,
      'card_loyalty' => Integer,
      'card_mana_cost' => String,
      'card_name' => String,
      'card_power' => String,
      'card_subtypes' => [String],
      'card_supertypes' => [String],
      'card_text' => String,
      'card_toughness' => String,
      'card_types' => [String],
      'card_type' => String,
    )

    is_expected.to include(
      'edition_code',
      'edition_name',
      'printing_multiverse_id',
      'printing_number',
      'printing_rarity',
      'user_printing_is_foil',
    )
  end

  it 'describes an existent card' do
    card = Card.find(id: subject['card_id'])

    expect(card).to be
    expect(card.name).to eq(subject['card_name'])
  end
end
