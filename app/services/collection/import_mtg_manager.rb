require 'csv'

module Services
  module Collection
    module ImportMTGManager
      extend self

      CONDITIONS = [
        UserPrinting::CONDITION_NM,
        UserPrinting::CONDITION_LP,
        UserPrinting::CONDITION_MP,
        UserPrinting::CONDITION_HP,
        UserPrinting::CONDITION_DM
      ].freeze

      def perform(import, user, io)
        ::CSV.new(io, headers: true).read.map do |row|
          card_params(row)
        end
      end

      private

      def card_params(data)
        condition = CONDITIONS[data['Condition'].to_i] if data['Condition']
        {
          count: data['Quantity'].to_i,
          name: data['Name'],
          edition: data['Code'],
          foil: data['Foil'] == '1',
          date: data['PurchaseDate'],
          condition: condition
        }
      end
    end
  end
end
