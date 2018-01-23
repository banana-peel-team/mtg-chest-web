require 'csv'

module Services
  module Collection
    module ImportFile
      def self.perform(title, file, user)
        DB.transaction do
          import = Import.create(
            user_id: user[:id],
            title: title,
            created_at: Time.now.utc
          )

          CSV.read(file, headers: true).map do |row|
            import_card(import, user, row)
          end

          import
        end
      end

      private_class_method
      def self.import_card(import, user, data)
        card = Card.where(name: data['Name']).first

        UserPrinting.create(
          import_id: import[:id],
          card_id: card[:id],
          edition_code: data['Code'],
          user_id: user[:id],
          foil: data['Foil'] == '1',
          count: data['Quantity'],
          added_date: data['PurchaseDate']
        )
      end
    end
  end
end
