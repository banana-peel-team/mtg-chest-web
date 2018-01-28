class User < Sequel::Model
  plugin :validation_helpers
  one_to_many :imports
  one_to_many :user_printings

  def validate
    validates_unique(:username)
  end
end
