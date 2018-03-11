Fabricator(:import) do
  user
  title 'test import'
  created_at { Time.now.utc }
  user_printing_count 0
end
