module API
  module V1
    module Presenters
      module UserPrinting
        def self.list(cards)
          cards.map { |card| single(card) }
        end

        def self.single(card)
          {
            user_printing_id: card[:user_printing_id],
            card_count: card[:count],
            card_id: card[:card_id],
            card_name: card[:card_name],
            card_converted_mana_cost: card[:converted_mana_cost],
            card_toughness: card[:toughness],
            card_power: card[:power],
            card_loyalty: card[:loyalty],
            card_mana_cost: card[:mana_cost],
            card_color_identity: card[:color_identity],
            card_types: card[:types],
            card_type: card[:type],
            card_layout: card[:layout],
            card_text: card[:text],
            card_subtypes: card[:subtypes],
            card_supertypes: card[:supertypes],
            card_colors: card[:colors],
            printing_foil: card[:foil],
            printing_condition: card[:condition],
            printing_flavor: card[:flavor],
            printing_rarity: card[:rarity],
            printing_added_date: card[:added_date],
            printing_multiverse_id: card[:multiverse_id],
            printing_number: card[:number],
            edition_name: card[:edition_name],
            edition_code: card[:edition_code],
            import_id: card[:import_id],
            import_name: card[:import_title],
          }
        end
      end
    end
  end
end