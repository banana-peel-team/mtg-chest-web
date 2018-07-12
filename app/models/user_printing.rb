class UserPrinting < Sequel::Model
  CONDITION_MN = 'MN' # Mint
  CONDITION_NM = 'NM' # Near Mint
  CONDITION_LP = 'LP' # Light Played
  CONDITION_MP = 'MP' # Moderately Played
  CONDITION_HP = 'HP' # Heavily Played
  CONDITION_DM = 'DM' # Damaged

  one_to_many :deck_cards
  many_to_one :printing
  many_to_one :import
  many_to_one :user

  dataset_module do
    def not_in_decks
      in_decks = DeckCard
        .in_use
        .where(
          user_printing_id: Sequel[:user_printings][:id],
          removed_at: nil,
        )

      not_in_decks = exclude(in_decks.exists)
    end
  end

  def self.create_many(count, attrs)
    printings = count.times.map { attrs }
    multi_insert(printings)
  end
end
