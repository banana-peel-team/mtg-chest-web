module Services
  module SystemDecks
    module Create
      extend self

      def perform(deck_db, attrs)
        DB.transaction do
          deck = Deck.create(
            name: attrs[:deck_title],
            card_count: 0,
            created_at: Time.now.utc
          )

          DeckMetadata.create(
            deck_id: deck[:id],
            external_id: attrs[:deck_id],
            deck_database_id: deck_db[:id],
            event_id: attrs[:event_id],
            event_title: attrs[:event_title],
            event_format: attrs[:event_format],
          )

          create_cards(deck, attrs[:cards_ids])

          deck.update(card_count: deck.deck_cards.count)
          update_scores(deck_db, deck)
          update_relations(attrs[:cards_ids])

          deck
        end
      end

      private

      def update_scores(deck_db, deck)
        scores = Sequel.pg_jsonb_op(:scores)

        cards_ids =
          DeckCard
            .association_join(:card)
            .not_basic_land
            .where(deck_id: deck[:id])
            .select_map(:card_id)

        score_for_db = scores.get_text(deck_db[:key])

        current_score = Sequel
          .function(:coalesce, score_for_db, '0')
          .cast(:integer)

        sum = Sequel.+(current_score, 1).cast(:text).cast(:jsonb)

        Card
          .where(id: cards_ids)
          .update(scores: scores.set("{#{deck_db[:key]}}", sum))

        deck_db.update(max_score: Card.max(score_for_db))
      end

      def update_relations(cards_ids_)
        cards_ids = Card
          .where(id: cards_ids_)
          .not_basic_lands
          .order(:id)
          .select_map(:id)

        all_combinations = cards_ids.combination(2).to_a
        combinations = all_combinations.dup

        ds = CardRelation.dataset

        combination = combinations.shift
        combination.sort!

        ds = CardRelation.where { |ds|
          ((ds.card_1_id =~ combination[0]) & (ds.card_2_id =~ combination[1]))
        }

        combinations.each do |cmb|
          cmb.sort!

          ds = ds.or { |ds|
            ((ds.card_1_id =~ cmb[0]) & (ds.card_2_id =~ cmb[1]))
          }
        end

        existing = ds.select_map([:card_1_id, :card_2_id])
        new_combinations = all_combinations - existing

        if existing.any?
          ds.update(strength: Sequel.+(:strength, 1))
        end

        records = new_combinations.map do |(id_1, id_2)|
          {
            card_1_id: id_1,
            card_2_id: id_2,
            strength: 1,
          }
        end
        CardRelation.multi_insert(records)
      end

      def create_cards(deck, cards_ids)
        cards = cards_ids.map do |card_id|
          next unless card_id
          {
            deck_id: deck[:id],
            card_id: card_id,
            added_at: Time.now.utc,
            slot: 'deck',
          }
        end

        unless cards.all?
          STDERR.puts "There are missing cards for deck: #{deck[:name]}."
          STDERR.puts " ...Failing."
        end

        DeckCard.multi_insert(cards)
      end
    end
  end
end
