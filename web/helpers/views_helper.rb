module Web
  module Helpers
    module ViewsHelper
      def haml_icon(name)
        haml_tag('i.fas', class: "fa-#{name}")
      end

      def card_score(dbs, card)
        dbs.each do |db|
          haml_tag(:span, card[:card_scores][db[:key]], title: db[:name])
        end
      end

      def alternatives_link(deck, card)
        path = "/decks/#{deck[:id]}/cards/#{card[:card_id]}/alternatives"

        haml_tag(:a, href: path) do
          haml_tag('i.fas.fa-exchange-alt', title: 'Alternatives') do
            haml_tag('span.alt-text', 'alternatives')
          end
        end
      end

      def synergy_deck_link(deck, card)
        path = "/decks/#{deck[:id]}/cards/#{card[:card_id]}/synergy"

        haml_tag(:a, href: path) do
          haml_tag('i.fas.fa-trophy',
                   title: 'Cards that work well with this') do
            haml_tag('span.alt-text', 'synergy')
          end
        end
      end

      def form(opts)
        opts = {method: 'post'}.merge(opts)

        haml_tag(:form, opts) do
          haml_concat(csrf.form_tag) if opts[:method] != 'get'

          yield
        end
      end

      def delete_button
        opts = { type: 'submit', value: 'Delete' }
        haml_tag('button.btn.btn-sm.btn-outline-danger', opts) do
          haml_icon('trash-alt')
        end
      end

      def delete_form(path, opts = {})
        form(opts) do
          if opts[:method] != 'get'
            haml_tag(:input, type: 'hidden', name: '_method', value: 'delete')
          end

          yield
        end
      end

      def count_badge(count)
        return if count == 1

        element = 'span.badge.badge-primary.badge-pill'

        haml_tag(element, count, title: "#{count} cards")
      end

      def list_printings(printings, rated_decks)
        partial('printings/_list', with_count: true,
                                   printings: printings,
                                   rated_decks: rated_decks)
      end
    end
  end
end
