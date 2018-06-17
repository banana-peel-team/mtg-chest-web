class DeckCard < Sequel::Model
  many_to_one :card
  many_to_one :deck
  many_to_one :user_printing

  dataset_module do
    # TODO: reuse Card.not_basic_lands?
    def not_basic_lands
      exclude(
        'Basic' => Sequel.pg_array(:supertypes).any,
        'Land' => Sequel.pg_array(:types).any,
      )
    end
  end

  def self.create_many(count, attrs)
    cards = count.times.map { attrs }
    multi_insert(cards)
  end
end
