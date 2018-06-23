module Web
  module Views
    class Layout
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

      attr_reader :current_user

      def initialize(attrs)
        @current_user = attrs[:current_user]
        @csrf_token = attrs[:csrf_token]
      end

      def render(&block)
        attrs = { csrf_token: @csrf_token }

        Html.render(attrs) do |html|
          html.html5 do
            html.tag('head') do
              html.append_html(DEFAULT_HEAD_TAGS)

              unless current_user
                html.append_html(stylesheet('/css/login.css'))
              end
            end

            body(html, &block)
          end
        end
      end

      def body(html, &block)
        html.tag('body', class: 'bg-light', lang: 'en') do
          if current_user
            navigation(html)

            html.tag('main', class: 'container', role: 'main') do
              block.call(html)
            end
          else
            block.call(html)
          end
        end
      end

      def navigation(html)
        cls = 'navbar navbar-expand-md navbar-dark bg-dark fixed-top'

        html.tag('nav', class: cls) do
          html.tag('a', class: 'navbar-brand', href: '/') do
            html.tag('i', class: 'fas fa-home')
          end

          html.tag('div', class: 'collapse navbar-collapse') do
            html.tag('ul', class: 'navbar-nav bd-navbar-nav flex-row') do
              nav_item(html, '/editions', 'Editions')
              nav_item(html, '/collection', 'Collection')
              nav_item(html, '/collection/imports', 'Imports')
              nav_item(html, '/decks', 'Decks')
            end
          end

          logout_button(html)
        end
      end

      def nav_item(html, link, content)
        html.tag('li', class: 'nav-item') do
          html.tag('a', class: 'nav-link', href: link) do
            html.append_html(content)
          end
        end
      end

      def logout_button(html)
        html.tag('div', class: 'align-right') do
          html.form(action: '/session/delete', class: 'form-inline') do
            button_attrs = {
              class: 'form-control btn',
              type: 'submit',
              title: 'Sign out',
              value: 'Sign out',
            }

            html.tag('button', button_attrs) do
              html.tag('i', class: 'fas fa-sign-out-alt')
            end
          end
        end
      end

      def stylesheet(src)
        %Q(<link type="text/css" rel="stylesheet" href="#{src}" />)
      end
    end
  end
end
