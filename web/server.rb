require 'cuba'
require 'cuba/safe'
require 'cuba/render'
require 'i18n'

Cuba.use(Rack::Session::Cookie, secret: ENV['RACK_SESSION_SECRET'])
Cuba.use(Rack::MethodOverride)
Cuba.plugin(Cuba::Safe)
Cuba.plugin(Cuba::Render)

Cuba.settings[:render][:template_engine] = 'haml'
Cuba.settings[:render][:views] = './web/views'
Cuba.settings[:render][:layout] = 'layout'

I18n.load_path = [['./web/locales/en.yml']]
I18n.locale = :en

require_relative 'helpers/login_helper'
require_relative 'helpers/common_helper'
require_relative 'helpers/mtg_helper'

Cuba.plugin(Helpers::LoginHelper)
Cuba.plugin(Helpers::CommonHelper)
Cuba.plugin(Helpers::MTGHelper)

require './app/application'
require_relative 'routes/sessions'
require_relative 'routes/editions'
require_relative 'routes/collection'
require_relative 'routes/decks'

Cuba.define do
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

  on('sessions') { run(Routes::Sessions) }
  on('editions') { run(Routes::Editions) }
  on('collection') { run(Routes::Collection) }
  on('decks') { run(Routes::Decks) }

  on('home') do
    render('home')
  end

  run(Rack::File.new('./public'))
end
