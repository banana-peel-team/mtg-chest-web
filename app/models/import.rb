class Import < Sequel::Model
  one_to_many :user_printings
  many_to_one :user

  def safe_title
    title.downcase.gsub(/\W+/, '-')
  end
end
