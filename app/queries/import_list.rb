module Queries
  module ImportList
    def self.for_user(user)
      user.imports_dataset.select(
        Sequel[:imports][:id].as(:import_id),
        Sequel[:imports][:title].as(:import_title),
        Sequel[:imports][:created_at],
        Sequel[:imports][:user_printing_count].as(:import_cards_count),
      )
    end
  end
end
