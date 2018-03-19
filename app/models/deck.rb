class Deck < Sequel::Model
  one_to_many :deck_cards
  many_to_one :user
end
