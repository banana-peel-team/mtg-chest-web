module Queries
  module DeckCards
    extend self

    DATASET = Sequel[:deck_card]

    WITH_OPTIONAL_PRINTING =
      DeckCard
        .from_self(alias: :deck_card)
        .association_join(:deck, :card)
        .left_join(
          Sequel[:user_printings].as(:user_printing),
          id: :user_printing_id
        )
        .left_join(Sequel[:printings].as(:printing), id: :printing_id)
        .left_join(Sequel[:editions].as(:edition), code: :edition_code)
        .where(removed_at: nil)

    def ignored(deck_id)
      Queries::Cards.deck_cards(
        DeckCard
          .association_join(:deck, :card)
          .where(deck_id: deck_id)
          .where(slot: 'ignored')
          .where(removed_at: nil)
      )
    end

    def scratchpad(deck_id)
      Queries::Cards.collection_cards(
        WITH_OPTIONAL_PRINTING
          .where(removed_at: nil)
          .where(slot: 'scratchpad')
          .where(deck_id: deck_id),
          false
      ).select_append(Sequel[:deck_card][:id].as(:deck_card_id))
    end

    def for_edit_deck(deck_id)
      Queries::Cards.collection_cards(
        WITH_OPTIONAL_PRINTING
          .where(removed_at: nil)
          .where(slot: 'deck')
          .where(deck_id: deck_id),
          false
      ).select_append(
        Sequel[:deck_card][:id].as(:deck_card_id),
        Sequel[:deck_card][:is_flagged],
      )
    end

    def for_link(deck)
      in_decks = DeckCard.where(
        user_printing_id: Sequel[:user_printing][:id],
        removed_at: nil,
      )

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

    def for_user_on_deck(user, deck_id)
      not_in_decks = user
        .user_printings_dataset
        .not_in_decks
        .association_join(:printing)

      Queries::Cards.cards_with_collection(
        DeckCard
          .in_deck
          .from_self(alias: :deck_card)
          .association_join(:deck, :card)
          .left_join(
            not_in_decks
              .group_and_count(:card_id),
              { card_id: :card_id },
              { table_alias: :collection }
          )
          .where(
            deck_id: deck_id,
          )
        )
    end

    def fields_singles(dataset)
      dataset.select_group(
        Sequel[:card][:color_identity].as(:card_color_identity),
        Sequel[:card][:colors].as(:card_colors),
        Sequel[:card][:converted_mana_cost].as(:card_converted_mana_cost),
        Sequel[:card][:id].as(:card_id),
        Sequel[:card][:layout].as(:card_layout),
        Sequel[:card][:loyalty].as(:card_loyalty),
        Sequel[:card][:mana_cost].as(:card_mana_cost),
        Sequel[:card][:name].as(:card_name),
        Sequel[:card][:power].as(:card_power),
        Sequel[:card][:scores].as(:card_scores),
        Sequel[:card][:subtypes].as(:card_subtypes),
        Sequel[:card][:supertypes].as(:card_supertypes),
        Sequel[:card][:text].as(:card_text),
        Sequel[:card][:toughness].as(:card_toughness),
        Sequel[:card][:type].as(:card_type),
        Sequel[:card][:types].as(:card_types),
        Sequel[:edition][:code].as(:edition_code),
        Sequel[:edition][:name].as(:edition_name),
        Sequel[:printing][:rarity].as(:printing_rarity),
        Sequel[:printing][:number].as(:printing_number),
        Sequel[:printing][:multiverse_id].as(:printing_multiverse_id),
        Sequel[:user_printing][:foil].as(:user_printing_is_foil),
        Sequel[:user_printing][:id].as(:user_printing_id),
      )
    end

    def fields(dataset)
      #dataset = DeckCard
        #.from_self(alias: :deck_card)
        #.in_deck
        #.association_join(:deck, :card)
        #.left_join(Sequel[:user_printings].as(:user_printing), {
          #id: :user_printing_id
        #})
        #.left_join(Sequel[:printings].as(:printing), id: :printing_id)
        #.left_join(Sequel[:editions].as(:edition), code: :edition_code)

      dataset = dataset.select_group(
        Sequel[:card][:color_identity].as(:card_color_identity),
        Sequel[:card][:colors].as(:card_colors),
        Sequel[:card][:converted_mana_cost].as(:card_converted_mana_cost),
        Sequel[:card][:id].as(:card_id),
        Sequel[:card][:layout].as(:card_layout),
        Sequel[:card][:loyalty].as(:card_loyalty),
        Sequel[:card][:mana_cost].as(:card_mana_cost),
        Sequel[:card][:name].as(:card_name),
        Sequel[:card][:power].as(:card_power),
        Sequel[:card][:scores].as(:card_scores),
        Sequel[:card][:subtypes].as(:card_subtypes),
        Sequel[:card][:supertypes].as(:card_supertypes),
        Sequel[:card][:text].as(:card_text),
        Sequel[:card][:toughness].as(:card_toughness),
        Sequel[:card][:type].as(:card_type),
        Sequel[:card][:types].as(:card_types),
        Sequel[:edition][:code].as(:edition_code),
        Sequel[:edition][:name].as(:edition_name),
        Sequel[:printing][:rarity].as(:printing_rarity),
        Sequel[:printing][:number].as(:printing_number),
        Sequel[:printing][:multiverse_id].as(:printing_multiverse_id),
        Sequel[:user_printing][:foil].as(:user_printing_is_foil),
      )
      .select_append(Sequel.function(:count).*.as(:card_count))
    end

    def for_deck(deck_id)
      dataset = DeckCard
        .from_self(alias: :deck_card)
        .in_deck
        .association_join(:deck, :card)
        .left_join(Sequel[:user_printings].as(:user_printing), {
          id: :user_printing_id
        })
        .left_join(Sequel[:printings].as(:printing), id: :printing_id)
        .left_join(Sequel[:editions].as(:edition), code: :edition_code)

      fields(dataset).where(deck_id: deck_id)
    end

    #def cards_in_decks(user)
      ## FIXME: Take into account that the user might
      ## have multiple copies of the same card.
      ## We have to include UserPrinting around here
      #DeckCard
        #.association_join(:deck)
        #.where(user_id: user[:id])
        #.where(removed_at: nil)
        #.where(slot: ['deck', 'sideboard']) # Include scratchpad?
    #end

    #def not_in_any_deck(user, cards, dataset)
      #dataset
        #.exclude(
          #cards[:id] => cards_in_decks(user).select(:card_id),
        #)
    #end

    def not_in_deck(deck_id, cards, dataset)
      deck_cards = DeckCard.where(deck_id: deck_id)

      dataset
        .exclude(
          cards[:id] => deck_cards.select(:card_id),
        )
    end

    def deck_identity(deck_id, cards, dataset)
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
    def deck_types(deck_id, cards, dataset)
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

    def related_to_deck(deck_id, cards, dataset)
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

    def suggestions(user, deck_id)
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

    def alternatives(user, deck_id, card)
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

      fields(ds)
    end

    def synergy(user, deck_id, card)
      cards = Sequel[:card]

      related = card
        .related_cards_dataset

      ds = user
        .user_printings_dataset
        .from_self(alias: :user_printing)
        .association_join(printing: [:card, :edition])
        .where(Sequel[:card][:id] => related.select(:id))

      ds = Queries::Cards.same_identity(card, ds)
      #ds = ds.same_identity(card)
      ds = not_in_deck(deck_id, cards, ds)
      #ds = not_in_any_deck(user, cards, ds)

      fields(ds)
    end
  end
end
