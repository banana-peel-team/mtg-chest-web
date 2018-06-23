require 'csv'

module Services
  module Collection
    module ImportDeckbox
      extend self

      def perform(import, user, io)
        cache = {
          editions: Hash.new { |h, k| h[k] = edition_code(k) },
        }

        csv = ::CSV.new(io, headers: true, encoding: 'UTF-8')
        csv.read.map do |row|
          card_params(row, cache)
        end
      end

      private

      def edition_code(name)
        edition = Edition.select(:code).where(name: name).first
        return unless edition

        edition[:code]
      end

      def card_params(data, cache)
        name = data['Name']

        if %r(\A(.*?)\s//).match(name)
          name = $1
        end

        {
          edition: cache[:editions][data['Edition']],
          name: name,
          # TODO: Map correct values
          condition: data['Condition'] || 'Near Mint',
          count: data['Count'].to_i,
          foil: data['Foil'] == 'foil',
        }
      end
    end
  end
end
