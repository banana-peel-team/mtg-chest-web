require 'cuba'
require 'cuba/safe'

require './app/application'

require_relative 'helpers/login_helper'
require_relative 'helpers/common_helper'
require_relative 'helpers/mtg_helper'

module Web
  class Server < Cuba
    use(Rack::Session::Cookie, secret: ENV['RACK_SESSION_SECRET'])
    use(Rack::MethodOverride)
    plugin(Cuba::Safe)

    plugin(Web::Helpers::LoginHelper)
    plugin(Web::Helpers::CommonHelper)
    plugin(Web::Helpers::MTGHelper)
  end
end

require_relative 'views/html'
require_relative 'views/layout'

require_relative 'routes/sessions'
require_relative 'routes/editions'
require_relative 'routes/collection'
require_relative 'routes/decks'
require_relative 'routes/deck_cards'
require_relative 'routes/home'

Web::Server.define do
  # TODO:?
  if ENV['RACK_ENV'] != 'test'
    on csrf.unsafe? do
      csrf.reset!

      res.status = 403
      res.write('Cannot validate post request.')
      halt(res.finish)
    end
  end

  on(root) do
    if current_user
      redirect_to('/home')
    else
      redirect_to('/sessions/new')
    end
  end

  on('sessions') { run(Web::Routes::Sessions) }
  on('editions') { run(Web::Routes::Editions) }
  on('collection') { run(Web::Routes::Collection) }
  on('decks') { run(Web::Routes::Decks) }
  on('deck-cards') { run(Web::Routes::DeckCards) }
  on('home') { run(Web::Routes::Home) }

  run(Rack::File.new('./public'))
end
