class User < Sequel::Model
  plugin :validation_helpers
  one_to_many :imports

  def validate
    validates_unique(:username)
  end
end
