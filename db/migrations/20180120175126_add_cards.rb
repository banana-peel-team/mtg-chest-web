Sequel.migration do
  change do
    create_table(:editions) do
      primary_key(:code, String, null: false)

      column(:name, String, null: false)
      column(:gatherer_code, String, null: false)
      column(:mci_code, String, null: false)
      column(:type, String, null: false)
      column(:block, String, null: false)
      column(:online_only, String, null: false)
      column(:release_date, DateTime, null: false)

      index(:name, unique: true)
    end

    create_table(:cards) do
      primary_key(:id)

      column(:layout, String, null: false)
      column(:name, String, null: false)
      column(:names, 'varchar[]', null: true)
      column(:mana_cost, String, null: true)
      column(:converted_mana_cost, Float, null: true)
      column(:colors, 'varchar[]', null: true)
      column(:color_identity, 'varchar[]', null: true)
      column(:type, String, null: false)
      column(:supertypes, 'varchar[]', null: true)
      column(:types, 'varchar[]', null: true)
      column(:subtypes, 'varchar[]', null: true)
      column(:power, String, null: true)
      column(:toughness, String, null: true)
      column(:loyalty, Integer, null: true)
      column(:text, String, null: true)

      index(:name)
    end

    create_table(:printings) do
      primary_key(:id)

      foreign_key(:edition_code, :editions, type: String, null: false)
      foreign_key(:card_id, :cards, null: false)

      column(:multiverse_id, 'bigint', null: true)
      column(:image_name, String, null: false)
      column(:watermark, String, null: true)
      column(:artist, String, null: true)
      column(:number, String, null: true)
      column(:rarity, String, null: false)
      column(:mci_number, String, null: true)
      column(:flavor, String, null: true)

      index(:multiverse_id, uniqe: true)
    end
  end
end
