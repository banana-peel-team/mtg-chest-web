require 'csv'

module Services
  module Collection
    module ImportDeckedBuilder
      def self.perform(import, user, file)
        cache = {
          editions: Hash.new { |h, k| h[k] = edition_code(k) },
        }

        File.readlines(file).each do |line|
          next unless (line =~ %r(^///)) == 0

          match = /mvid:(\d+)\sqty:(\d+)/.match(line)
          row = {
            multiverse_id: match[1].to_i,
            count: match[2].to_i
          }
          import_card(import, user, row, cache)
        end
      end

      def self.card_name_id(name)
        card = Card.select(:id).where(name: name).first

        return card[:id] if card
      end
      private_class_method :card_name_id

      def self.edition_code(name)
        edition = Edition.select(:code).where(name: name).first

        return edition[:code] if edition
      end
      private_class_method :edition_code

      def self.import_card(import, user, data, cache)
        printing = Printing.where(multiverse_id: data[:multiverse_id]).first

        UserPrinting.create(
          import_id: import[:id],
          printing_id: printing[:id],
          user_id: user[:id],
          foil: false, # TODO
          count: data[:count],
          added_date: Time.now.utc,
          # TODO: We don't receive this from decked
          condition: 'Near Mint'
        )
      end
      private_class_method :import_card
    end
  end
end
