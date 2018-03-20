module API
  module V1
    module Presenters
      module CollectionCard
        def self.single(printing)
          {
            card_count: printing[:count],
            card_id: printing[:card_id],
            card_name: printing[:card_name],
            card_converted_mana_cost: printing[:converted_mana_cost],
            card_toughness: printing[:toughness],
            card_power: printing[:power],
            card_loyalty: printing[:loyalty],
            card_mana_cost: printing[:mana_cost],
            card_color_identity: printing[:color_identity],
          }
        end
      end
    end
  end
end
