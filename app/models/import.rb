class Import < Sequel::Model
  one_to_many :user_printings
end
