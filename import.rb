require './app/application'

if ARGV.size.zero?
  STDERR.puts "Filename not given."
end

ARGV.each do |file|
  Services::Editions::ImportAll.perform(file)
end
