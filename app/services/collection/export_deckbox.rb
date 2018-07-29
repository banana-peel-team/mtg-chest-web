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

      extend self

      #
      # Deckbox columns:
      # Count,Name,Edition,Card Number,Condition,Language,Foil,Signed,
      # Artist Proof,Altered Art,Misprint,Promo,Textless,My Price
      #
      def perform(printings)
        printings.map do |printing|
          {
            'Condition' => CONDITIONS.fetch(
              printing[:user_printing_condition],
              'Mint'
            ),
            'Language' => 'English',
            'Count' => printing[:card_count],
            'Name' => name(printing),
            'Edition' => edition(printing),
            'Foil' => printing[:user_printing_is_foil] ? 'foil' : nil
          }
        end
      end

      private

      def edition(printing)
        SETS_MAP.fetch(printing[:edition_name], printing[:edition_name])
      end

      def name(printing)
        if printing[:card_layout] == 'aftermath'
          return printing[:card_names].join(' // ')
        end

        printing[:card_name]
      end
    end
  end
end
