module Services
  module Collection
    module ExportDeckbox
      CONDITIONS = {
        UserPrinting::CONDITION_MN => 'Mint',
        UserPrinting::CONDITION_NM => 'Near Mint',
        UserPrinting::CONDITION_LP => 'Good (Lightly Played)',
        UserPrinting::CONDITION_MP => 'Played',
        UserPrinting::CONDITION_HP => 'Heavily Played',
        UserPrinting::CONDITION_DM => 'Poor'
      }.freeze

      SETS_MAP = {
        'Magic: The Gathering—Conspiracy' => 'Conspiracy'
      }.freeze

      #
      # Deckbox columns:
      # Count,Name,Edition,Card Number,Condition,Language,Foil,Signed,Artist Proof,Altered Art,Misprint,Promo,Textless,My Price
      #
      def self.perform(printings)
        printings.map do |printing|
          {
            'Condition' => CONDITIONS.fetch(printing[:condition], 'Near Mint'),
            'Language' => 'English',
            'Count' => 1,
            'Name' => name(printing),
            'Edition' => edition(printing),
            'Foil' => printing[:foil] ? 'foil' : nil
          }
        end
      end

      def self.edition(printing)
        SETS_MAP.fetch(printing[:edition_name], printing[:edition_name])
      end
      private_class_method :edition

      def self.name(printing)
        if printing[:layout] == 'aftermath'
          return printing[:names].join(' // ')
        end

        printing[:card_name]
      end
      private_class_method :name
    end
  end
end
