require 'csv'

module Services
  module Collection
    module ImportDeckbox
      def self.perform(import, user, file)
        cache = {
          editions: Hash.new { |h, k| h[k] = edition_code(k) },
        }

        ::CSV.read(file, headers: true, encoding: 'utf-8').map do |row|
          import_card(import, user, row, cache)
        end
      end

      def self.card_name_id(name)
        card = Card.select(:id).where(name: name).first

        card[:id]
      end
      private_class_method :card_name_id

      def self.edition_code(name)
        edition = Edition.select(:code).where(name: name).first

        edition[:code]
      end
      private_class_method :edition_code

      def self.import_card(import, user, data, cache)
        edition_code = cache[:editions][data['Edition']]
        card_id = card_name_id(data['Name'])

        printing = Printing
          .select(:id)
          .where(card_id: card_id, edition_code: edition_code)
          .first

        UserPrinting.create(
          import_id: import[:id],
          printing_id: printing[:id],
          user_id: user[:id],
          foil: data['Foil'] == 'foil',
          count: data['Count'],
          added_date: Time.now.utc,
          condition: data['Condition'] || 'Near Mint'
        )
      end
      private_class_method :import_card
    end
  end
end
