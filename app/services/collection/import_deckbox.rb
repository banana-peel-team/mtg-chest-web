require 'csv'

module Services
  module Collection
    module ImportDeckbox
      def self.perform(import, user, io)
        cache = {
          editions: Hash.new { |h, k| h[k] = edition_code(k) },
        }

        csv = ::CSV.new(io, headers: true, encoding: 'UTF-8')
        csv.read.map do |row|
          import_card(import, user, row, cache)
        end
      end

      def self.card_name_id(name)
        if %r(\A(.*?)\s//).match(name)
          name = $1
        end

        card = Card.select(:id).where(name: name).first

        raise name.inspect unless card
        card[:id]
      end
      private_class_method :card_name_id

      def self.edition_code(name)
        edition = Edition.select(:code).where(name: name).first
        return unless edition

        edition[:code]
      end
      private_class_method :edition_code

      def self.import_card(import, user, data, cache)
        edition_code = cache[:editions][data['Edition']]
        # TODO: What to do here?
        return unless edition_code
        card_id = card_name_id(data['Name'])

        printing = Printing
          .select(:id)
          .where(card_id: card_id, edition_code: edition_code)
          .first

        UserPrinting.create_many(
          data['Count'].to_i,
          import_id: import[:id],
          printing_id: printing[:id],
          user_id: user[:id],
          foil: data['Foil'] == 'foil',
          added_date: Time.now.utc,
          # TODO: Map correct values
          condition: data['Condition'] || 'Near Mint'
        )
      end
      private_class_method :import_card
    end
  end
end
