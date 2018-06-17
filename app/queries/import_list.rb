module Queries
  module ImportList
    def self.for_user(user)
      user.imports_dataset
    end
  end
end
