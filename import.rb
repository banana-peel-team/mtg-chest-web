require './app/application'

if ARGV.size.zero?
  STDERR.puts "Filename not given."
  STDERR.puts " Use - for stdin."
  exit
end

Services::Editions::ImportAll.perform(ARGF.read)
