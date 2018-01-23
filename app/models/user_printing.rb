class UserPrinting < Sequel::Model
  many_to_one :card
  many_to_one :edition
  many_to_one :printing
end
