module Routes
  class Cards < Cuba
    define do
      on(get, root) do
        render('cards/index', cards: Card.all)
      end
    end
  end
end
