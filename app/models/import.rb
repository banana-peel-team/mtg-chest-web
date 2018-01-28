class Import < Sequel::Model
  one_to_many :user_printings

  def safe_title
    title.downcase.gsub(/\W+/, '-')
  end
end
