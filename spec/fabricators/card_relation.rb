Fabricator(:card_relation) do
  card_left { Fabricate(:card) }
  card_right { Fabricate(:card) }
  strength 1
end
