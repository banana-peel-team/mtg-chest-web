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

      def self.perform(user, attrs)
        # TODO: Error handling
        service = HANDLERS.fetch(attrs[:source])

        DB.transaction do
          import = ::Import.create(
            user_id: user[:id],
            title: attrs[:title],
            created_at: Time.now.utc,
            user_printing_count: 0
          )

          File.open(attrs[:file], 'r') do |io|
            service.perform(import, user, io)
          end

          sum = import.user_printings_dataset.sum(:count)
          import.update(user_printing_count: sum)

          import
        end
      end
    end
  end
end
