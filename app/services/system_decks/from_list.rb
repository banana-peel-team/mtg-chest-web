module Services
  module SystemDecks
    module FromList
      # CSV row:
      # event_id,event_title,event_format,deck_id,deck_title
      # 18787,GP Phoenix 2018,MO,317513,Humans

      def self.create(deck_db, attrs)
        attrs.dup
        file = attrs.delete(:file)
        attrs[:cards_ids] = get_cards_ids(file)

        if attrs[:cards_ids].empty?
          STDERR.puts(" ** Skipping deck with no cards: " +
                      "#{attrs[:event_id]}/#{attrs[:deck_id]}")
          return
        end

        Services::SystemDecks::Create.perform(
          deck_db,
          attrs
        )
      end

      def self.get_cards_ids(file)
        card_count = file.readlines.each_with_object({}) do |line, obj|
          line.chomp!
          count, name = line.split(' ', 2)

          if name =~ %r(\A(.*)\s+//)
            name = $1
          end

          obj[name] ||= 0
          obj[name] += count.to_i
        end

        card_ids = Card.where(name: card_count.keys).as_hash(:name, :id)

        card_count.each_with_object([]) do |(name, count), obj|
          count.times.each { obj << card_ids[name] }
        end
      end
    end
  end
end
