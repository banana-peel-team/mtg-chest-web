require './lib/html'

require_relative 'shared/nav_signout'

require_relative 'editions/navigation/list'
require_relative 'cards/navigation/database'
require_relative 'collection/navigation/show'
require_relative 'imports/navigation/list'
require_relative 'decks/navigation/list'
require_relative 'find_decks/navigation/list'

module Web
  module Views
    # TODO: Clean up this mess
    class Layout < ::Html::Component
      # Cached tags
      DEFAULT_HEAD_TAGS = Html.render do |html|
        html.meta(charset: 'utf-8')
        html.meta(
          name: 'viewport',
          content: 'width=device-width,initial-scale=1, shrink-to-fit=no'
        )

        attrs = { type: 'text/css', rel: 'stylesheet' }
        stylesheets = [
          {
            href: '///maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/' +
                  'bootstrap.min.css',
            crossorigin: 'annonymous',
            integrity: 'sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmF' +
                      'cJlSAwiGgFAW/dAiS6JXm',
          },
          {
            href: '//cdn.jsdelivr.net/npm/keyrune@latest/css/keyrune.css',
            crossorigin: 'annonymous',
          },
          {
            href: '///use.fontawesome.com/releases/v5.0.8/css/all.css',
            crossorigin: 'annonymous',
            integrity: 'sha384-3AB7yXWz4OeoZcPbieVW64vVXEwADiYyAEhwilzWsLw' +
                       '+9FgqpyjjStpPnpBO8o8S',
          },
          { href: '/css/mana-master.min.css' },
          { href: '/css/app.css' },
          { href: '/css/mana.css' },
        ]

        stylesheets.each do |sheet|
          html.stag('link', attrs.merge(sheet))
        end
      end.freeze

      # Cached navigation
      NAVIGATION = Html.render do |html|
        cls = 'navbar navbar-expand-md navbar-dark bg-dark fixed-top'

        html.tag('nav', class: cls) do
          html.tag('a', class: 'navbar-brand', href: '/') do
            html.tag('i', class: 'fas fa-home')
          end

          html.tag('div', class: 'collapse navbar-collapse') do
            html.tag('ul', class: 'navbar-nav bd-navbar-nav flex-row') do
              ctx = {}
              Editions::Navigation::List.static.render(html, ctx)
              Cards::Navigation::Database.static.render(html, ctx)
              Collection::Navigation::Show.static.render(html, ctx)
              Imports::Navigation::List.static.render(html, ctx)
              Decks::Navigation::List.static.render(html, ctx)
              FindDecks::Navigation::List.static.render(html, ctx)
            end
          end

          Shared::NavSignout.static.render(html, {})
        end
      end.freeze

      def render(html, context)
        current_user = context[:current_user]

        html.html5 do
          html.tag('head'.freeze) do
            html.append_html(DEFAULT_HEAD_TAGS)

            unless current_user
              html.append_html(stylesheet('/css/login.css'.freeze))
            end
          end

          html.tag('body'.freeze, class: 'bg-light'.freeze,
                                  lang: 'en'.freeze) do
            if current_user
              html.append_html(NAVIGATION)

              html.tag('main'.freeze, class: 'container'.freeze,
                                      role: 'main'.freeze) do
                render_children(html, context)
              end
            else
              render_children(html, context)
            end
          end
        end
      end
    end
  end
end
