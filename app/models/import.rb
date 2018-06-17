class Import < Sequel::Model
  one_to_many :user_printings
  many_to_one :user
  many_to_many :deck_cards, join_table: :user_printings,
    left_key: :import_id,
    right_key: :id,
    right_primary_key: :user_printing_id

  def safe_title
    title.downcase.gsub(/\W+/, '-')
  end
end
