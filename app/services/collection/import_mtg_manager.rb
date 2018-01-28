require 'csv'

module Services
  module Collection
    module ImportMTGManager
      CONDITIONS = [
        UserPrinting::CONDITION_NM,
        UserPrinting::CONDITION_LP,
        UserPrinting::CONDITION_MP,
        UserPrinting::CONDITION_HP,
        UserPrinting::CONDITION_DM
      ].freeze

      def self.perform(import, user, file)
        ::CSV.read(file, headers: true).map do |row|
          import_card(import, user, row)
        end
      end

      private_class_method
      def self.import_card(import, user, data)
        printing = Printing.association_join(:card).where(
          Sequel.qualify(:card, :name) => data['Name'],
          Sequel.qualify(:printings, :edition_code) => data['Code']
        ).select(Sequel.qualify(:printings, :id)).first

        condition = CONDITIONS[data['Condition'].to_i] if data['Condition']

        UserPrinting.create(
          import_id: import[:id],
          printing_id: printing[:id],
          user_id: user[:id],
          foil: data['Foil'] == '1',
          count: data['Quantity'],
          added_date: data['PurchaseDate'],
          condition: condition
        )
      end
    end
  end
end
