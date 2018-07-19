require_relative 'extensions/table'

module Web
  module Routes
    module Presenters
      class EditionCards
        attr_reader :edition
        attr_reader :user

        def initialize(edition, user, options)
          @edition = edition
          @user = user
          @params = options[:params]
        end

        def context
          {
            printings: Extensions::Table.table(printings, @params, {
              sort: Queries::Cards,
              default_sort: 'card_name',
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
                identity_r: filter?('r') ? '1' : nil,
                identity_g: filter?('g') ? '1' : nil,
                identity_b: filter?('b') ? '1' : nil,
                identity_u: filter?('u') ? '1' : nil,
                identity_w: filter?('w') ? '1' : nil,
              },
            }),
            edition: edition,
            rated_decks: rated_decks,
          }
        end

        private

        def filter?(color)
          filter_identity[color] == '1'
        end

        def param_hash(params, name)
          param = params[name]
          return {} unless param && param.is_a?(Hash)

          param
        end

        def filter
          @filter ||= param_hash(@params, 'filter')
        end

        def rated_decks
          DeckDatabase.select(:key, :name, :max_score).all
        end

        def filter_identity
          @filter_identity ||= filter['i'] || {}
        end

        def printings
          ds = Queries::EditionCards.for_edition(edition[:code], user)

          if filter_identity.any?
            ds = Queries::Cards.filter_identity(
              ds, filter_identity.keys.map(&:upcase)
            )
          end
          ds
        end
      end
    end
  end
end
