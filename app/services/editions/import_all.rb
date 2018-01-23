require 'yajl'

module Services
  module Editions
    module ImportAll
      def self.perform(filename)
        obj = parse(filename)

        obj.each do |code, set|
          Services::Editions::Import.perform(set)
        end
      end

      private_class_method
      def self.parse(filename)
        stream = File.new(filename, 'r')

        Yajl::Parser.parse(stream)
      end
    end
  end
end
