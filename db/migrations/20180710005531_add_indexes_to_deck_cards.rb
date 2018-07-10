Sequel.migration do
  up do
    add_index(:deck_cards, :user_printing_id)
  end

  down do
    drop_index(:deck_cards, :user_printing_id)
  end
end
