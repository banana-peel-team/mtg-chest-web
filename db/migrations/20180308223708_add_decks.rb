Sequel.migration do
  up do
    create_table(:decks) do
      primary_key(:id)

      foreign_key(:user_id, :users, null: false)

      column(:name, String, null: false)
      column(:card_count, Integer, null: false)
      column(:created_at, DateTime, null: false)
    end

    create_table(:deck_cards) do
      primary_key(:id)

      foreign_key(:deck_id, :decks, null: false)
      foreign_key(:card_id, :cards, null: false)
      foreign_key(:user_printing_id, :user_printings, null: true)

      column(:card_count, Integer, null: false)
      column(:added_at, DateTime, null: false)
    end
  end

  down do
    drop_table(:deck_cards)
    drop_table(:decks)
  end
end
