Fabricator(:user_printing) do
  user
  # TODO:
  import { |attrs| Fabricate(:import, user: attrs[:user]) }
  printing

  foil false
  added_date { Time.now.utc }
  condition 'NM'
end
