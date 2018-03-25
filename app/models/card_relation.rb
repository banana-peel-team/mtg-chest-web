class CardRelation < Sequel::Model
  #unrestrict_primary_key

  many_to_one :card_left, class: :Card, key: :card_1_id
  many_to_one :card_right, class: :Card, key: :card_2_id

  #create_table(:card_relations) do
    #foreign_key(:card_1_id, :cards, null: false)
    #foreign_key(:card_2_id, :cards, null: false)

    #primary_key([:card_1_id, :card_2_id])
    #column(:strength, Integer, null: false)
  #end
end
