Fabricator(:user_printing) do
  user
  import
  printing

  foil false
  added_date { Time.now.utc }
  condition 'NM'
end
