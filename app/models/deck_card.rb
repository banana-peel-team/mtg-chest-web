class DeckCard < Sequel::Model
  many_to_one :card
end
