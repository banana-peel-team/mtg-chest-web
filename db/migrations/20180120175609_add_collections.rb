Sequel.migration do
  change do
    create_table(:imports) do
      primary_key(:id)

      foreign_key(:user_id, :users, null: false)

      column(:title, String, null: false)
      column(:created_at, DateTime, null: false)
      column(:user_printing_count, Integer, null: false)
    end

    create_table(:user_printings) do
      primary_key(:id)

      foreign_key(:user_id, :users, null: false)
      foreign_key(:import_id, :imports, null: false)

      foreign_key(:printing_id, :printings, null: false)

      column(:count, Integer, null: false)
      column(:foil, FalseClass, null: false)
      column(:added_date, DateTime, null: false)
      column(:condition, String, null: false)
    end
  end
end
