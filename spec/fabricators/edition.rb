Fabricator(:edition) do
  code { sequence(:code) { |i| "ED#{i}" } }
  name { sequence(:name) { |i| "Edition #{i}" } }

  gatherer_code 'CODE'
  mci_code 'CODE'
  type 'core'
  block 'Block name'
  online_only 'false'
  release_date { Time.now - rand }
end
