require_relative 'extensions/table'

module Web
  module Routes
    module Presenters
      class ShowCollection
        attr_reader :user

        def initialize(user, options = {})
          @user = user

          @params = options[:params]
        end

        def context
          {
            printings: Extensions::Table.table(cards, @params, {
              sort: Queries::UserPrintings,
              default_sort: 'card_name',
              sort_columns: [
                'card_name',
                'cmc',
                'deck_name',
                'identity',
                'import_name',
                'power',
                'score',
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

        def filter?(color)
          filter_identity[color] == '1'
        end

        def filter_identity
          @filter_identity ||= filter['i'] || {}
        end

        def rated_decks
          DeckDatabase.select(:key, :name, :max_score).all
        end

        def cards
          ds = Queries::UserPrintings.full_for_user(user)

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
