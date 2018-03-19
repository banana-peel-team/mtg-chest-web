class DeckCard < Sequel::Model
  many_to_one :card
  many_to_one :deck

  def self.create_many(count, attrs)
    cards = count.times.map { attrs }
    multi_insert(cards)
  end
end
