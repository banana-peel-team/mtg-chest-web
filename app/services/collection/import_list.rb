module Services
  module Collection
    module ImportList
      extend self

      # TODO: integrate with Collection::Import
      def perform(user, attrs)
        # TODO: Error handling
        DB.transaction do
          import = ::Import.create(
            user_id: user[:id],
            title: attrs[:title],
            created_at: Time.now.utc,
            user_printing_count: 0
          )

          attrs[:list].each do |line|
            import_card(import, user, line, attrs)
          end

          count = import.user_printings_dataset.count
          import.update(user_printing_count: count)

          import
        end
      end

      private

      def import_card(import, user, line, params)
        count, name = line.split(' ', 2)

        printing = Printing.association_join(:card).where(
          Sequel.qualify(:card, :name) => name,
          Sequel.qualify(:printings, :edition_code) => params[:edition_code]
        ).select(Sequel.qualify(:printings, :id)).first

        UserPrinting.create_many(
          count.to_i,
          import_id: import[:id],
          printing_id: printing[:id],
          user_id: user[:id],
          foil: params[:foil],
          added_date: Time.now.utc,
          condition: params[:condition],
        )
      end
    end
  end
end
