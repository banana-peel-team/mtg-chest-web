module API
  module V1
    module Presenters
      module Card
        def self.single(card)
          {
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
          }
        end
      end
    end
  end
end
