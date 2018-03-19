Fabricator(:deck) do
  user

  name 'Deck name'
  card_count 0
  created_at { Time.now.utc }
end
