require 'cuba'
require 'cuba/safe'
require 'cuba/render'
require 'i18n'
require 'haml/helpers'

require './app/application'

require_relative 'helpers/login_helper'
require_relative 'helpers/common_helper'
require_relative 'helpers/mtg_helper'
require_relative 'helpers/views_helper'

I18n.load_path = [['./web/locales/en.yml']]
I18n.locale = :en

module Web
  class Server < Cuba
    use(Rack::Session::Cookie, secret: ENV['RACK_SESSION_SECRET'])
    use(Rack::MethodOverride)
    plugin(Cuba::Render)
    plugin(Cuba::Safe)

    settings[:render][:template_engine] = 'haml'
    settings[:render][:views] = './web/views'
    settings[:render][:layout] = 'layout'

    plugin(::Haml::Helpers)
    plugin(Web::Helpers::LoginHelper)
    plugin(Web::Helpers::CommonHelper)
    plugin(Web::Helpers::MTGHelper)
    plugin(Web::Helpers::ViewsHelper)
  end
end

require_relative 'routes/sessions'
require_relative 'routes/editions'
require_relative 'routes/collection'
require_relative 'routes/decks'

Web::Server.define do
  on csrf.unsafe? do
    csrf.reset!

    res.status = 403
    res.write('Not authorized')
    halt(res.finish)
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

  on('home') do
    render('home')
  end

  run(Rack::File.new('./public'))
end
