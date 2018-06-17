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

if ARGV.size < 1
  STDERR.puts "USE: import_decks.rb 'deck-db-key' path/to/file.json"
  STDERR.puts " OR: cat path/to/file.json | import_decks.rb 'deck-db-key'"
  exit 1
end

deck_key = ARGV.shift

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

Services::SystemDecks::FromArchive.import(deck_db, ARGF.read)
