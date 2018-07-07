require_relative 'deck_cards'
require_relative 'extensions/table'

module Web
  module Routes
    module Presenters
      class DeckSuggestions < DeckCards
        attr_reader :sorting

        def initialize(user, deck, options)
          @user = user
          @deck = deck
          @params = options[:params] || {}
        end

        def context
          {
            suggestions: Extensions::Table.table(suggestions, @params, {
              sort: Queries::Cards,
              default_sort: 'score',
              default_dir: 'desc',
              sort_columns: [
                'score',
                'card_name',
                'cmc',
                'identity',
                'power',
                'toughness',
              ],
              paginate: true,
            }).merge({
              filters: {
                all: show_all? ? '1' : nil,
                identity_r: filter?('r') ? '1' : nil,
                identity_g: filter?('g') ? '1' : nil,
                identity_b: filter?('b') ? '1' : nil,
                identity_u: filter?('u') ? '1' : nil,
                identity_w: filter?('w') ? '1' : nil,
              },
            }),
            deck: deck,
            rated_decks: rated_decks,
          }
        end

        private

        def param_hash(params, name)
          param = params[name]
          return {} unless param && param.is_a?(Hash)

          param
        end

        def filter
          @filter ||= param_hash(@params, 'filter')
        end

        def show_all?
          filter['a'] == '1'
        end

        def filter?(color)
          filter_identity[color] == '1'
        end

        def filter_identity
          @filter_identity ||= filter['i'] || {}
        end

        def suggestions
          @suggestions ||=
            begin
              user = show_all? ? nil : @user

              ds = Queries::DeckCards.suggestions(user, @deck[:id])

              if filter_identity.any?
                ds = Queries::DeckCards.filter_identity(
                  ds, filter_identity.keys.map(&:upcase)
                )
              end

              ds
            end
        end
      end
    end
  end
end
