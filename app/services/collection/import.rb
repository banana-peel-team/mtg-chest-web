require_relative 'import_mtg_manager'
require_relative 'import_deckbox'
require_relative 'import_decked_builder'

module Services
  module Collection
    module Import
      HANDLERS = {
        'deckbox' => Services::Collection::ImportDeckbox,
        'mtg-manager' => Services::Collection::ImportMTGManager,
        'decked-builder' => Services::Collection::ImportDeckedBuilder,
      }.freeze

      extend self

      def perform(user, attrs)
        # TODO: Error handling
        service = HANDLERS.fetch(attrs[:source])

        DB.transaction do
          import = ::Import.create(
            user_id: user[:id],
            title: attrs[:title],
            created_at: Time.now.utc,
            user_printing_count: 0
          )

          File.open(attrs[:file], 'rb') do |io|
            service.perform(import, user, io).each do |card|
              import_card(import, user, card)
            end
          end

          count = import.user_printings_dataset.count
          import.update(user_printing_count: count)

          import
        end
      end

      private

      def card_printing_id(data)
        if data[:multiverse_id]
          return Printing
            .where(multiverse_id: data[:multiverse_id])
            .select_map(:id)
            .first
        end

        edition_code = data[:edition]
        # TODO: What to do here?
        return unless edition_code
        card_id = card_name_id(data[:name])

        Printing
          .where(card_id: card_id, edition_code: edition_code)
          .select_map(:id)
          .first
      end

      def import_card(import, user, data)
        printing_id = card_printing_id(data)

        # TODO: what to do here?
        return unless printing_id
        #raise data.inspect unless printing_id

        UserPrinting.create_many(
          data[:count],
          import_id: import[:id],
          printing_id: printing_id,
          user_id: user[:id],
          foil: data[:foil],
          added_date: Time.now.utc,
          condition: data[:condition],
        )
      end

      def card_name_id(name)
        Card.where(name: name).select_map(:id).first
      end
    end
  end
end
