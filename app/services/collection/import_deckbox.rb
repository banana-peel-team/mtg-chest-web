require 'csv'

require_relative '../editions/import_all'

module Services
  module Collection
    module ImportDeckbox
      extend self

      EDITIONS_MAP = {
        'Conspiracy' => 'Magic: The Gathering—Conspiracy',
      }.freeze

      def perform(import, user, io)
        cache = {
          editions: Hash.new { |h, k| h[k] = edition_code(k) },
        }

        csv = ::CSV.new(io, headers: true, encoding: 'UTF-8')
        csv.read.map do |row|
          if Edition.supported_name?(row['Edition'])
            card_params(row, cache)
          end
        end.reject(&:nil?)
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

        edition_name = data['Edition']
        edition_name = EDITIONS_MAP.fetch(edition_name, edition_name)
        edition_code = cache[:editions][edition_name]

        {
          edition: edition_code,
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
