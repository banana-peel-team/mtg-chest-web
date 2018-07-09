class Deck < Sequel::Model
  one_to_many :deck_cards
  #many_to_many :cards, join_table: :deck_cards
  many_to_one :user
  one_to_one :deck_metadata

  def update_card_count
    count = deck_cards_dataset
      .where(slot: 'deck', removed_at: nil)
      .count

    update(card_count: count)
  end
end
