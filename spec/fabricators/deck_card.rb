Fabricator(:deck_card) do
  card
  deck
  slot 'deck'
  added_at { Time.now.utc }
end
