Fabricator(:printing) do
  edition
  card

  multiverse_id { sequence(:multiverse_id) }
  image_name 'test'
  watermark "none"
  artist "Artist"
  number "123a"
  rarity 'common'
  mci_number 123
  flavor "Flavor"
end
