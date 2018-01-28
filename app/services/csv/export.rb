module Services
  module CSV
    module Export
      def self.perform(rows)
        csv = ::CSV.new('')
        headers = rows.first.keys

        csv << headers
        rows.each do |row|
          csv << headers.map { |header| row[header] }
        end

        csv
      end
    end
  end
end
