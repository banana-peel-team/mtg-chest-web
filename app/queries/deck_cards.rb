module Queries
  module DeckCards
    def self.ignored(deck_id)
      Queries::Cards.deck_cards(
        DeckCard
          .association_join(:deck, :card)
          .where(deck_id: deck_id)
          .where(slot: 'ignored')
          .where(removed_at: nil)
      )
    end

    def self.scratchpad(deck_id)
      Queries::Cards.collection_cards(
        DeckCard
          .from_self(alias: :deck_card)
          .left_join(
            Sequel[:user_printings].as(:user_printing),
            id: :user_printing_id
          )
          .left_join(Sequel[:printings].as(:printing), id: :printing_id)
          .left_join(Sequel[:editions].as(:edition), code: :edition_code)
          .association_join(:deck, :card)
          .where(deck_id: deck_id)
          .where(slot: 'scratchpad')
          .where(removed_at: nil),
          false
      ).select_append(Sequel[:deck_card][:id].as(:deck_card_id))
    end

    def self.for_edit_deck(deck_id)
      Queries::Cards.collection_cards(
        DeckCard
          .from_self(alias: :deck_card)
          .association_join(:deck, :card)
          .left_join(
            Sequel[:user_printings].as(:user_printing),
            id: :user_printing_id
          )
          .left_join(Sequel[:printings].as(:printing), id: :printing_id)
          .left_join(Sequel[:editions].as(:edition), code: :edition_code)
          .where(deck_id: deck_id)
          .where(slot: 'deck')
          .where(removed_at: nil),
          false
      ).select_append(
        Sequel[:deck_card][:id].as(:deck_card_id),
        Sequel[:deck_card][:is_flagged],
      )
    end

    def self.for_link(deck)
      in_decks = DeckCard.where(user_printing_id: Sequel[:user_printing][:id])

      ds = UserPrinting
        .from_self(alias: :user_printing)
        .association_join(:import, printing: [:card, :edition])
        .where(
          Sequel[:printing][:card_id] => DeckCard
            .where(
              deck_id: deck[:id],
              user_printing_id: nil,
              slot: 'deck',
              removed_at: nil
            )
            .select(:card_id),
          Sequel[:user_printing][:user_id] => deck[:user_id]
        )
        .exclude(in_decks.exists)


      Queries::Cards.collection_cards(ds, false)
        .select_append(
          Sequel[:import][:id].as(:import_id),
          Sequel[:import][:title].as(:import_title),
        )
        .order(Sequel[:card][:name], Sequel[:edition][:code])
    end

    def self.for_deck(deck_id)
      Queries::Cards.cards(
        DeckCard
          .from_self(alias: :deck_card)
          .association_join(:deck, :card)
          .where(
            deck_id: deck_id,
            slot: 'deck',
            removed_at: nil,
          )
      )
    end

    def self.cards_in_decks(user)
      # FIXME: Take into account that the user might
      # have multiple copies of the same card.
      # We have to include UserPrinting around here
      DeckCard
        .association_join(:deck)
        .where(user_id: user[:id])
        .where(removed_at: nil)
        .where(slot: ['deck', 'sideboard']) # Include scratchpad?
    end

    def self.not_in_any_deck(user, cards, dataset)
      dataset
        .exclude(
          cards[:id] => cards_in_decks(user).select(:card_id),
        )
    end

    def self.not_in_deck(deck_id, cards, dataset)
      deck_cards = DeckCard.where(deck_id: deck_id)

      dataset
        .exclude(
          cards[:id] => deck_cards.select(:card_id),
        )
    end

    def self.deck_identity(deck_id, cards, dataset)
      cards_in_deck = DeckCard
        .association_join(:card)
        .where(deck_id: deck_id)
        .where(removed_at: nil)

      dataset
        .where(
          cards[:color_identity] => cards_in_deck.select(:color_identity)
        )
    end

    # TODO: Implement this?
    def self.deck_types(deck_id, cards, dataset)
      cards_in_deck = DeckCard
        .association_join(:card)
        .where(deck_id: deck_id)
        .exclude(subtypes: nil)

      dataset.where(
        Sequel.pg_array(:subtypes).overlaps(
          cards_in_deck.select(Sequel.function(:array_agg, :subtypes))
        )
      )
    end

    def self.related_to_deck(deck_id, cards, dataset)
      deck_cards = DeckCard.where(
        deck_id: deck_id,
        slot: 'deck',
      )

      dataset.where(
        cards[:id] => CardRelation.where(
                        card_1_id: deck_cards.select(:card_id)
                      ).select(:card_2_id)
      ).or(
        cards[:id] => CardRelation.where(
                        card_2_id: deck_cards.select(:card_id)
                      ).select(:card_1_id)
      )
    end

    def self.suggestions(user, deck_id)
      cards = Sequel[:card]

      ds =
        if user
          user.user_printings_dataset
            .from_self(alias: :user_printing)
            .association_join(printing: [:card, :edition])
        else
          Card
            .from_self(alias: :card)
            #.association_left_join(printings: [:user_printings, :edition])
        end

      ds = related_to_deck(deck_id, cards, ds)

      ds = deck_identity(deck_id, cards, ds)
      #ds = deck_types(deck_id, cards, ds)
      ds = not_in_deck(deck_id, cards, ds)

      if user
        Queries::Cards.collection_cards(ds)
      else
        Queries::Cards.cards(ds)
      end
    end

    def self.sort_null_length(ds, column, dir)
      sort_str =
        case dir
        when 'desc'
          "LENGTH(#{column}) DESC NULLS LAST, #{column} DESC NULLS LAST"
        else 'asc'
          "LENGTH(#{column}) ASC NULLS LAST, #{column} ASC NULLS LAST"
        end

      ds.order(Sequel.lit(sort_str))
    end

    def self.sort_null_array_length(ds, column, dir)
      arr_len = "ARRAY_LENGTH(#{column}, 1)"
      sort_str =
        case dir
        when 'desc'
          "#{arr_len} DESC NULLS LAST, #{column} DESC NULLS LAST"
        else 'asc'
          "#{arr_len} ASC NULLS LAST, #{column} ASC NULLS LAST"
        end

      ds.order(Sequel.lit(sort_str))
    end

    def self.sort_nulls(ds, column, dir)
      sort_str =
        case dir
        when 'desc'
          "#{column} DESC NULLS LAST"
        else 'asc'
          "#{column} ASC NULLS LAST"
        end

      ds.order(Sequel.lit(sort_str))
    end

    def self.sort_dir(ds, column, dir)
      case dir
      when 'desc'
        ds.order(Sequel.desc(column))
      else 'asc'
        ds.order(Sequel.asc(column))
      end
    end

    def self.sort(ds, column, dir)
      case column
      when 'score'
        sort_dir(ds, Sequel[:card][:scores], dir)
      when 'name'
        sort_dir(ds, Sequel[:card][:name], dir)
      when 'identity'
        sort_null_array_length(ds, 'card.color_identity', dir)
      #when 'tags'
        #sort_nulls(ds, 'card.tags', dir)
      when 'power'
        sort_null_length(ds, 'card.power', dir)
      when 'toughness'
        sort_null_length(ds, 'toughness', dir)
      when 'cmc'
        sort_nulls(ds, 'converted_mana_cost', dir)
      else
        ds
      end
    end

    def self.filter_identity(ds, colors)
      ds
        .where(
          Sequel
            .pg_array(Sequel[:card][:color_identity])
            .overlaps(Sequel.pg_array(colors, :varchar))
        )
    end

    def self.alternatives(user, deck_id, card)
      cards = Sequel[:card]

      ds = user.user_printings_dataset
        .from_self(alias: :user_printing)
        .association_join(printing: [:card, :edition])

      ds = deck_identity(deck_id, cards, ds)
      #ds = ds.same_identity(card)
      ds = not_in_deck(deck_id, cards, ds)
      #ds = not_in_any_deck(user, cards, ds)

      if card.subtypes
        ds = ds.where(Sequel.pg_array(:subtypes).overlaps(card.subtypes))
      elsif card.types
        ds = ds.where(Sequel.pg_array(:types).overlaps(card.types))
      end

      if card.converted_mana_cost
        cmc = card.converted_mana_cost

        ds = ds.where(
          Sequel.lit('converted_mana_cost BETWEEN ? AND ?', cmc - 1, cmc + 1)
        )
      end

      Queries::Cards.collection_cards(ds)
    end

    def self.synergy(user, deck_id, card)
      cards = Sequel[:card]

      ds = card
        .related_cards_dataset
        .from_self(alias: :card)
        .association_join(printings: :edition)

      if user
        ds = ds
          .association_left_join(printings: [:user_printings])
          .where {
            (Sequel[:user_printing][:user_id] =~ user[:id]) |
            (Sequel[:user_printing][:user_id] =~ nil)
          }
      end

      ds = ds.same_identity(card)
      ds = not_in_deck(deck_id, cards, ds)
      ds = not_in_any_deck(user, cards, ds)


      ds = Queries::Cards.collection_cards(ds)

      ds
    end
  end
end
