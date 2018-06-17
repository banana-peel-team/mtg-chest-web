class DeckDatabase < Sequel::Model
  one_to_many :deck_metadatas
end
