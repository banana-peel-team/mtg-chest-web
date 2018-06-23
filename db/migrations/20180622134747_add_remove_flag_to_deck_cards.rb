Sequel.migration do
  up do
    alter_table(:deck_cards) do
      add_column(:is_flagged, FalseClass)
    end
  end

  down do
    alter_table(:deck_cards) do
      drop_column(:is_flagged)
    end
  end
end
