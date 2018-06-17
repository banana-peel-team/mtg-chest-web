Sequel.migration do
  up do
    extension(:pg_enum)

    create_enum(:deck_slot, %w(
                deck
                sideboard
                scratchpad
                ignored
               ))

    alter_table(:deck_cards) do
      add_column(:removed_at, DateTime, null: true)
      add_column(:slot, :deck_slot)
    end

    from(:deck_cards).update(slot: 'deck')

    alter_table(:deck_cards) do
      set_column_not_null(:slot)
    end
  end

  down do
    extension(:pg_enum)

    alter_table(:deck_cards) do
      drop_column(:removed_at)
      drop_column(:slot)
    end

    drop_enum(:deck_slot)
  end
end
