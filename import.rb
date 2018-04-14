require './app/application'

if ARGV.size.zero?
  STDERR.puts "Filename not given."
  exit
end

Services::Editions::ImportAll.perform(ARGF.read)
