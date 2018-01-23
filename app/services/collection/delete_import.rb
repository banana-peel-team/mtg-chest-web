module Services
  module Collection
    module DeleteImport
      def self.perform(import)
        import.user_printings_dataset.delete
        import.delete
      end
    end
  end
end
