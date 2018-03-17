class DeckCard < Sequel::Model
  many_to_one :card
  many_to_one :deck
end
