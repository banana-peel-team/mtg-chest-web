module Services
  module Editions
    module Import
      def self.perform(set)
        edition = create_edition(set)

        set['cards'].each do |data|
          card = import_card(data)

          create_printing(card[:id], edition[:code], data)
        end
      end

      def self.create_edition(set)
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
      private_class_method :create_edition

      def self.create_printing(card_id, set_code, data)
        Printing.create(
          card_id: card_id,
          edition_code: set_code,
          multiverse_id: data['multiverseid'],
          rarity: data['rarity'],
          number: data['number'],
          image_name: data['imageName'],
          watermark: data['watermark'],
          mci_number: data['mciNumber'],
          flavor: data['flavor'],
          artist: data['artist']
        )
      rescue Exception => e
        puts " * Error creating printing for #{data['name']} on set #{set_code}"

        raise e
      end
      private_class_method :create_printing

      def self.import_card(data)
        card = Card.where(name: data['name']).select(:id).first
        card ||= Card.create(
          layout: data['layout'],
          name: data['name'],
          names: data['names'],
          mana_cost: data['manaCost'],
          converted_mana_cost: data['cmc'],
          colors: colors_array(data['colors']),
          color_identity: string_array(data['colorIdentity']),
          type: data['type'],
          supertypes: string_array(data['supertypes']),
          types: string_array(data['types']),
          subtypes: string_array(data['subtypes']),
          text: data['text'],
          power: data['power'],
          toughness: data['toughness'],
          loyalty: data['loyalty'],
        )
      end
      private_class_method :import_card

      def self.colors_array(colors)
        return unless colors
        colors = colors.map do |color|
          next 'U' if color == 'Blue'

          color[0]
        end

        string_array(colors)
      end
      private_class_method :colors_array

      def self.string_array(value)
        return unless value

        Sequel.pg_array(value, :varchar)
      end
      private_class_method :string_array
    end
  end
end
