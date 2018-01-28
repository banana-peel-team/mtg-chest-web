require 'yajl'

module Services
  module Editions
    module ImportAll
      UNSUPPORTED_SETS = [
        'UST'
      ].freeze

      def self.perform(filename)
        obj = parse_json_file(filename)

        if obj.key?('cards')
          import_set(obj)
        else
          import_sets(obj.values)
        end
      end

      def self.import_set(set)
        unless set_supported?(set)
          puts " >> Skipping:  %8s - %s ... (Not supported set)" % [set['code'], set['name']]

          return
        end

        if set_exists?(set)
          puts " >> Skipping:  %8s - %s ... (Already imported)" % [set['code'], set['name']]

          return
        else
          puts " >> Importing: %8s - %s ..." % [set['code'], set['name']]
        end

        DB.transaction do
          Services::Editions::Import.perform(set)
        end
      end
      private_class_method :import_set

      def self.set_supported?(set)
        !UNSUPPORTED_SETS.include?(set['code'])
      end
      private_class_method :set_supported?

      def self.set_exists?(set)
        !Edition.where(code: set['code']).empty?
      end
      private_class_method :set_exists?

      def self.sort_sets(sets)
        sets.sort do |a, b|
          a['releaseDate'] <=> b['releaseDate']
        end
      end
      private_class_method :sort_sets

      def self.import_sets(sets)
        sort_sets(sets).each do |set|
          import_set(set)
        end
      end
      private_class_method :import_sets

      def self.parse_json_file(filename)
        stream = File.new(filename, 'r')

        Yajl::Parser.parse(stream)
      end
      private_class_method :parse_json_file
    end
  end
end
