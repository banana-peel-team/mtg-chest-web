require_relative 'color_filter'

module Web
  module Views
    module Cards
      module Forms
        class IdentityFilter < ::Html::Component
          option :namespace, 'filter'
          option :source, :filters

          def draw
            namespace = nest_into(options[:namespace], :i)

            ::Html::Component.new(
              Forms::ColorFilter.new(
                color: 'r',
                source: :identity_r,
                name: nest_into(namespace, 'r'),
              ),
              Forms::ColorFilter.new(
                color: 'g',
                source: :identity_g,
                name: nest_into(namespace, 'g'),
              ),
              Forms::ColorFilter.new(
                color: 'b',
                source: :identity_b,
                name: nest_into(namespace, 'b'),
              ),
              Forms::ColorFilter.new(
                color: 'u',
                source: :identity_u,
                name: nest_into(namespace, 'u'),
              ),
              Forms::ColorFilter.new(
                color: 'w',
                source: :identity_w,
                name: nest_into(namespace, 'w'),
              ),
            )
          end
        end
      end
    end
  end
end
