class Printing < Sequel::Model
  #unrestrict_primary_key

  many_to_one :card
  many_to_one :edition, key: :edition_code
  one_to_many :user_printings
end
