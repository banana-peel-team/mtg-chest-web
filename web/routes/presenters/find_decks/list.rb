require_relative '../extensions/table'

module Web
  module Routes
    module Presenters
      module FindDecks
        class List
          def initialize(user, options)
            @user = user
            @params = options[:params]
          end

          def context
            {
              decks: Extensions::Table.table(decks, @params, {
                sort: Queries::Decks,
                default_sort: 'count',
                default_dir: 'asc',
                sort_columns: [
                  'deck_name',
                  'count',
                  'format',
                  'source',
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

          def decks
            ds = Queries::Decks.suggestions(@user)

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
end
