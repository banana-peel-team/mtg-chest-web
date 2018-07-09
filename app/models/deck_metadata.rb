class DeckMetadata < Sequel::Model
  unrestrict_primary_key

  many_to_one :deck_database
end
