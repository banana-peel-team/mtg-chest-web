require './app/application'

# Create a CSV file with the list of the decks, with
# the following columns:
#
# event_id,event_title,event_format,deck_id,deck_title
#
# Metadata: (you can put whatever you want there)
#  - event_id
#  - event_title
#  - event_format (it could be helpful in the future if this
#                  contains things like Modern, Standard, etc)
#  - deck_id  - The external id, it will be used to load the
#               cards list.
#  - deck_title
#
# Then, for each row in the CSV, create a file named after
# the deck_id value with the plain list of cards:
#
#  2 Swamp
#  3 Plains
#  ...

if ARGV.size < 2
  STDERR.puts "USE: import_decks.rb 'deck-db-key' path/to/decks.csv"
  exit 1
end

deck_key = ARGV.first

deck_db = DeckDatabase.find(key: deck_key)

unless deck_db
  STDERR.puts %(
    Deck with key "#{deck_key}" not found.

   Create your deck db:

   deck_db = DeckDatabase.create(
     key: 'bestdecks',
     name: 'Best decks ever',
     max_score: 0, # max_score is maintained by import service
   )
  )
  exit 1
end

files = ARGV.drop(1)
files.each do |file|
  dir = File.dirname(file)

  File.open(file, 'rb') do |io|
    csv = ::CSV.new(io, headers: true, encoding: 'UTF-8')
    csv.read.map do |row|
      deck_file = File.join(dir, row['deck_id'])

      existing = DeckMetadata.where(
        external_id: row['deck_id'],
        deck_database_id: deck_db[:id],
      )

      unless existing.empty?
        puts " -> Skipping deck #{row['deck_id']}: #{row['deck_title']}"
        next
      end

      puts " -> Importing deck #{row['deck_id']}: #{row['deck_title']}"

      File.open(deck_file) do |io|
        attrs = {
          event_id: row['event_id'],
          event_title: row['event_title'],
          event_format: row['event_format'],
          deck_id: row['deck_id'],
          deck_title: row['deck_title'],
          file: io,
        }
        Services::SystemDecks::FromList.create(deck_db, attrs)
      end
    end
  end
end
