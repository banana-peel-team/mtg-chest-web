module Routes
  class Editions < Cuba
    define do
      on(get, root) do
        editions = Queries::Editions.list

        render('editions/index', editions: editions)
      end

      on(':code') do |code|
        edition = Edition.where(code: code).first

        on(get, root) do
          printings = Queries::EditionPrintings.for_edition(code)

          render('editions/show', printings: printings, edition: edition)
        end

        on('cards') do
          on(get, ':id') do |card_id|
            printings = [] #Printing
              #.where(card_id: card_id)
              #.all

            printing = Queries::PrintingDetails.for_card_on_edition(
              card_id, code
            )

            render('editions/card', card: printing,
                                    edition: edition,
                                    printings: printings)
          end
        end
      end
    end
  end
end
