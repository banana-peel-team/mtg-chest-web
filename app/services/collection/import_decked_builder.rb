require 'csv'

module Services
  module Collection
    module ImportDeckedBuilder
      extend self

      def perform(import, user, io)
        cards = []

        io.readlines.each do |line|
          match = %r(///.*?mvid:(\d+)\sqty:(\d+)).match(line)
          next unless match

          row = {
            count: match[2].to_i,
            multiverse_id: match[1].to_i,
            # TODO: We don't receive this from decked
            condition: UserPrinting::CONDITION_NM,
            # TODO:
            foil: false,
          }

          cards << row
        end

        cards
      end
    end
  end
end
