module Routes
  class Editions < Cuba
    define do
      on(get, root) do
        editions = Services::Editions::List.perform

        render('editions/index', editions: editions)
      end

      on(':code') do |code|
        edition = Edition.where(code: code).first

        on(get, root) do
          printings = Services::Editions::ListPrintings.perform(code)

          render('editions/show', printings: printings, edition: edition)
        end
      end
    end
  end
end
