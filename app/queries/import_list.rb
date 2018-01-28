module Queries
  module ImportList
    def self.for_user(user)
      user.imports
    end
  end
end
