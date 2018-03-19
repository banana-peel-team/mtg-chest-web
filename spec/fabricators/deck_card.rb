Fabricator(:deck_card) do
  card
  deck
  added_at { Time.now.utc }
end
