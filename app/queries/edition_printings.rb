module Queries
  class EditionPrintings
    def self.for_edition(code)
      Printing
        .association_join(:card, :edition)
        .where(edition_code: code)
        .select(
          Sequel.qualify(:edition, :code).as(:edition_code),
          Sequel.qualify(:edition, :name).as(:edition_name),
          Sequel.qualify(:card, :id).as(:card_id),
          Sequel.qualify(:card, :name).as(:card_name),
          Sequel.qualify(:card, :power).as(:power),
          Sequel.qualify(:card, :mana_cost),
          Sequel.qualify(:card, :toughness).as(:toughness),
          Sequel.qualify(:card, :types).as(:types),
          Sequel.qualify(:card, :subtypes).as(:subtypes),
          Sequel.qualify(:card, :color_identity).as(:color_identity),
          Sequel.qualify(:card, :colors).as(:colors),
          Sequel.qualify(:card, :scores).as(:card_scores),
        )
        .order(
          Sequel.qualify(:printings, :number)
        )
        .exclude(
          Sequel.qualify(:card, :type) => 'basic land'
        )
        .all
    end
  end
end
