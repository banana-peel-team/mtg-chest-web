class UserPrinting < Sequel::Model
  CONDITION_MN = 'MN' # Mint
  CONDITION_NM = 'NM' # Near Mint
  CONDITION_LP = 'LP' # Light Played
  CONDITION_MP = 'MP' # Moderately Played
  CONDITION_HP = 'HP' # Heavily Played
  CONDITION_DM = 'DM' # Damaged

  many_to_one :printing
  many_to_one :import
end
