require 'yajl'

module Services
  module SystemDecks
    module FromArchive
      extend self

      def import(deck_db, stream)
        obj = Yajl::Parser.parse(stream)

        obj.each do |_id, deck|
          import_deck(deck_db, deck)
        end
      end

      private

      def import_deck(deck_db, deck)
        attrs = {
          cards_ids: cards_ids_from_list(deck['cards']),
          event_id: deck['eventID'],
          deck_id: deck['deckID'],
          deck_title: deck['deckTitle'],
          event_title: deck['eventTitle'],
          event_format: deck['eventFormat'],
        }

        # I'd say five is a fine amount of cards, we might want to tune it.
        # There are decks having just two (different) cards. Yes.
        if attrs[:cards_ids].uniq.count < 5
          STDERR.puts(
            " ** Skipping deck with less than five different cards: " +
            "#{attrs[:event_id]}/#{attrs[:deck_id]}")
          return
        end

        existing = DeckMetadata.where(
          external_id: attrs[:deck_id],
          deck_database_id: deck_db[:id],
        )

        unless existing.empty?
          puts " -> Skipping deck #{attrs[:deck_id]}: #{attrs[:deck_title]}"

          return
        end

        puts " -> Importing deck #{attrs[:deck_id]}: #{attrs[:deck_title]}"

        Services::SystemDecks::Create.perform(
          deck_db,
          attrs
        )

      end

      def cards_ids_from_list(list)
        cards = list.each_with_object({}) do |(name, count), obj|
          if name =~ %r(\A(.*)\s+//)
            name = $1
          end

          obj[name] = count
        end

        cards_ids = Card.where(name: cards.keys).as_hash(:name, :id)

        cards.each_with_object([]) do |(name, count), obj|
          obj.concat([cards_ids[name]] * count)
          #count.times.each { obj << cards_ids[name] }
        end
      end
    end
  end
end
