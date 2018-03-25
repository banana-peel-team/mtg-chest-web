Sequel.migration do
  up do
    alter_table(:decks) do
      set_column_allow_null(:user_id)
    end

    alter_table(:cards) do
      add_column(:scores, :jsonb, null: false, default: '{}')
    end

    create_table(:deck_databases) do
      primary_key(:id)

      column(:name, String, null: false)
      column(:key, String, null: false, unique: true)
      column(:max_score, Integer, null: false)
    end

    create_table(:deck_metadatas) do
      foreign_key(:deck_id, :decks, null: false)

      foreign_key(:deck_database_id, :deck_databases, null: false)

      column(:event_id, Integer, null: false)
      column(:event_title, String, null: false)
      column(:event_format, String, null: false)
      column(:external_id, Integer, null: false)

      primary_key([:deck_id])
    end

    create_table(:card_relations) do
      foreign_key(:card_1_id, :cards, index: true, null: false)
      foreign_key(:card_2_id, :cards, index: true, null: false)

      column(:strength, Integer, null: false)
    end
  end

  down do
    drop_table(:card_relations)
    drop_table(:deck_metadatas)
    drop_table(:deck_databases)

    decks = from(:decks).where(user_id: nil)
    if decks.any?
      from(:deck_cards).where(deck_id: decks.select(:id)).delete
      decks.delete
    end

    alter_table(:cards) do
      drop_column(:scores)
    end

    alter_table(:decks) do
      set_column_not_null(:user_id)
    end
  end
end
