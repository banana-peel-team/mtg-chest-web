class Printing < Sequel::Model
  many_to_one :card
  many_to_one :edition, key: :edition_code
  one_to_many :user_printings, graph_alias_base: :user_printing
end
