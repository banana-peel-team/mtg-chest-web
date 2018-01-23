class Printing < Sequel::Model
  unrestrict_primary_key

  many_to_one :card
  many_to_one :edition
end
