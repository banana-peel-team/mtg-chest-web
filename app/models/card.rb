class Card < Sequel::Model
  MIN_RELATION_STRENGTH = 10

  one_to_many :printings

  # Relations to cards where related_id < card_id
  one_to_many :relations_to_left, class: :CardRelation, key: :card_2_id
  # Relations to cards where card_id < related_id
  one_to_many :relations_to_right, class: :CardRelation, key: :card_1_id

  many_to_many :related_cards_to_left,
    right_key: :card_1_id,
    left_key: :card_2_id,
    join_table: :card_relations,
    class: self

  many_to_many :related_cards_to_right,
    right_key: :card_2_id,
    left_key: :card_1_id,
    join_table: :card_relations,
    class: self

  many_to_many :related_cards, class: self, join_table: :card_relations,
    dataset: proc {

    strong_relations = CardRelation.where do |ds|
      ds.strength > MIN_RELATION_STRENGTH
    end

    Card
      .where(
        Sequel[:cards][:id] =>
        strong_relations.where(card_1_id: id).select(:card_2_id)
          .union(
            strong_relations.where(card_2_id: id).select(:card_1_id),
            from_self: true
          )
      )
  }

  dataset_module do
    def not_basic_lands
      exclude(
        'Basic' => Sequel.pg_array(:supertypes).any,
        'Land' => Sequel.pg_array(:types).any,
      )
    end
  end
end
