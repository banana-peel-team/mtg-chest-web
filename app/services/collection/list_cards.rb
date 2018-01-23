module Services
  module Collection
    module ListCards
      def self.perform(user)
        UserPrinting
          .association_join(:card)
          .where(user_id: user.id)
          .all
      end
    end
  end
end
