Fabricator(:deck_database) do
  name { sequence(:name) { |n| "Deck database #{n}" } }
  key { sequence(:key) { |n| "db-#{n}" } }

  max_score 0
end
