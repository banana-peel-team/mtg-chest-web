class Deck < Sequel::Model
  one_to_many :deck_cards
end
