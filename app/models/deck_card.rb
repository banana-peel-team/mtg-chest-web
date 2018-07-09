class DeckCard < Sequel::Model
  many_to_one :card
  many_to_one :deck
  many_to_one :user_printing

  dataset_module do
    where(:in_deck, slot: 'deck', removed_at: nil)
    where(:in_use, slot: %w(deck scratchpad sideboard), removed_at: nil)

    # TODO: reuse +Card.not_basic_lands+?
    exclude(:not_basic_land, {
      'Basic' => Sequel.pg_array(:supertypes).any,
      'Land' => Sequel.pg_array(:types).any,
    })
  end

  def self.create_many(count, attrs)
    cards = count.times.map { attrs }
    multi_insert(cards)
  end
end
