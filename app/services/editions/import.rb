module Services
  module Editions
    module Import
      def self.perform(set)
        create_edition(set)

        set_code = set['code']

        set['cards'].each do |data|
          card = import_card(data)
          printing = Printing.where(
            edition_code: set_code,
            card_id: card[:id],
          ).empty?

          return unless printing

          Printing.create(
            edition_code: set_code,
            card_id: card[:id],
            number: data['number']
          )
        end
      end

      private_class_method
      def self.create_edition(set)
        return unless Edition.where(code: set['code']).empty?

        puts " Creating edition: #{set['code']} ..."
        Edition.create(
          code: set['code'],
          name: set['name'],
          gatherer_code: set['gathererCode'] || set['code'],
          mci_code: set['magicCardsInfoCode'] || set['code'],
          release_date: Date.parse(set['releaseDate']),
          type: set['type'],
          block: set['block'] || set['name'], # TODO: maybe blocks are optional?
          online_only: set['onlineOnly'] == true
        )
      end

      def self.import_card(card)
        existing = Card.where(name: card['name']).select(:id).first
        return existing if existing

        Card.create(
          layout: card['layout'],
          name: card['name'],
          names: string_array(card['names']),
          mana_cost: card['manaCost'],
          converted_mana_cost: card['cmc'],
          colors: string_array(card['colors']),
          color_identity: string_array(card['colorIdentity']),
          type: card['type'],
          supertypes: string_array(card['supertypes']),
          types: string_array(card['types']),
          subtypes: string_array(card['subtypes']),
          rarity: card['rarity'],
          text: card['text'],
          flavor: card['flavor'],
          artist: card['artist'],
          power: card['power'],
          toughness: card['toughness'],
          loyalty: card['loyalty'],
          image_name: card['imageName'],
          watermark: card['watermark'],
          mci_number: card['mciNumber']
        )
      end

      private_class_method
      def self.string_array(value)
        Sequel.pg_array(value, :varchar) if value
      end
    end
  end
end
