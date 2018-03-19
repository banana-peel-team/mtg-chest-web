Fabricator(:printing) do
  edition
  card

  multiverse_id { sequence(:multiverse_id) }
  image_name 'test'
  watermark nil
  artist nil
  number nil
  rarity 'common'
  mci_number nil
  flavor nil
end
