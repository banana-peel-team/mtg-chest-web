require 'rubygems'
require 'bundler/setup'
require 'sequel'

DB = Sequel.connect(ENV.fetch('DATABASE_URL'))
DB.extension(:pg_array)
DB.extension(:pg_json)
DB.extension(:pg_enum)
Sequel.extension(:pg_array_ops)
Sequel.extension(:pg_json_ops)

require_relative 'models'
require_relative 'queries'
require_relative 'services'

if ENV['RACK_ENV'] == 'development'
  require 'byebug'
  require 'logger'
  DB.logger = Logger.new(STDERR)
end
