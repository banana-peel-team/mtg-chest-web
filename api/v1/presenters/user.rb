module API
  module V1
    module Presenters
      module User
        def self.single(user)
          {
            user_id: user[:id],
            username: user[:username],
          }
        end
      end
    end
  end
end
