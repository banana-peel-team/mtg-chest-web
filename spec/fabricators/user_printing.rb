Fabricator(:user_printing) do
  user
  import
  printing

  count 1
  foil false
  added_date { Time.now.utc }
  condition 'NM'
end
