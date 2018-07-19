module Web
  module Views
    module Extensions
      module MTG
        class Extension
          TAG_ICONS = {
            'Island' => 'u',
            'Forest' => 'g',
            'Mountain' => 'r',
            'Plains' => 'w',
            'Swamp' => 'b',
          }.freeze

          ICON_MAP = {
            't' => 'tap',
          }.freeze

          attr_reader :html

          def initialize(html)
            @html = html
          end

          def edition_icon(edition)
            cls = "ss ss-fw ss-#{edition[:edition_code].downcase}"
            html.tag('i', class: cls)
          end

          def printing_icon(card)
            return unless card[:edition_code]
            title = "#{card[:edition_name]} - #{card[:card_rarity]}"
            cls = 'mr-1 ss ss-fw'
            cls << " ss-#{card[:edition_code].downcase}"
            cls << " ss-#{card[:printing_rarity].downcase}"
            if card[:is_foil]
              cls << " ss-grad ss-foil"
              title << ' (Foil)'
            end

            html.tag('i', class: cls, title: title)
          end

          def printing_name_with_info(card, options = {})
            printing_icon(card)

            html.append_html(card[:card_name])

            # TODO: collection_count might be unused
            raise "collection_count is used." if card[:collection_count]
            count = card[:collection_count] || card[:count]
            if count && count > 0
              count_badge(count, options[:force_badge])
            end
          end

          def count_badge(count, force = false)
            return if !force && count == 1

            cls = 'ml-1 badge badge-secondary badge-pill'

            title = if count == 1
              '1 card'
            else
              "#{count} cards"
            end

            html.tag('span', count.to_s, class: cls, title: title)
          end

          def card_text(card)
            return unless card[:card_text]

            html.append_html('<div class="mtgText">')

            text = transform_icons(card[:card_text])
            html.append_html(text.gsub("\n", "<br />"))

            html.append_html('<div>')
          end

          def card_cost(card)
            html.append_html(transform_icons(card[:card_mana_cost]))
          end

          def icons_list(list)
            html.append_html(transform_icons_list(list))
          end

          # TODO: Rename?
          def tags(list)
            return unless list

            list.each do |t|
              tag(t)
            end
          end

          # TODO: Rename?
          def tag(t)
            icon = TAG_ICONS[t]

            return html.append_html(transform_icon(icon)) if icon

            html.append_html(
              %Q(<span class="mtgTag mtgTag--#{t.downcase}">#{t}</span> )
            )
          end

          def card_score(dbs, card)
            return unless card[:card_scores].any?

            dbs.each do |db|
              score = card[:card_scores][db[:key]]
              next unless score

              html.tag('span', score.to_s,
                      class: 'badge badge-pill',
                      title: db[:name])
            end
          end

          # TODO: Rename?
          def mtg_icon(name)
            html.tag('i', title: name, class: "mr-1 ms ms-#{name.downcase}")
          end

          def mtg_cost_icon(color)
            html.append_html(transform_icon(color))
          end

          # TODO: Rename?
          def mtg_icons(list)
            list.each(&method(:mtg_icon))
          end

          private

          def transform_double_icon(icona, iconb)
            icon = "#{icona}#{iconb}"

            %Q(<i class="mr ms ms-cost ms-split ms-#{icon}"></i>)
          end

          # TODO: Rename?
          def transform_icon(icon)
            icon = ICON_MAP.fetch(icon, icon)

            %Q(<i class="mr ms ms-cost ms-#{icon}"></i>)
          end

          def transform_icons(text)
            return unless text

            text = text.gsub(/{(\w+)}/) { transform_icon($1.downcase) }
            text.gsub(/{(\w+)\/(\w+)}/) do
              transform_double_icon($1.downcase, $2.downcase)
            end
          end

          # TODO: Rename?
          def transform_icons_list(icons)
            return unless icons

            icons.map { |icon| transform_icon(icon.downcase) }.join('')
          end
        end

        def mtg
          @mtg ||= MTG::Extension.new(self)
        end
      end
    end
  end
end
