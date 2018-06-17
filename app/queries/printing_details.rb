module Queries
  module PrintingDetails
    def self.for_card_on_edition(card_id, code)
      Printing
        .association_join(:card)
        .where(edition_code: code, card_id: card_id)
        .select(
          :edition_code,
          :multiverse_id,
          Sequel.qualify(:card, :text),
          Sequel.qualify(:card, :id).as(:card_id),
          Sequel.qualify(:card, :name).as(:card_name),
          Sequel.qualify(:card, :power).as(:power),
          Sequel.qualify(:card, :mana_cost),
          Sequel.qualify(:card, :toughness).as(:toughness),
          Sequel.qualify(:card, :type).as(:type),
          Sequel.qualify(:card, :types).as(:types),
          Sequel.qualify(:card, :subtypes).as(:subtypes),
          Sequel.qualify(:card, :color_identity).as(:color_identity),
          Sequel.qualify(:card, :colors).as(:colors),
        )
    end
  end
end
