module Web
  module Views
    module Helpers
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

      def self.printing_symbol(html, card)
        return unless card[:edition_code]
        # TODO: colorize
        edition = "ss-#{card[:edition_code].downcase}"
        rarity = "ss-#{card[:card_rarity].downcase}"
        html.tag('i', class: "ss #{edition} #{rarity}")
        html.append_html(' ')
        #%i{class: "ss ss-#{printing[:edition_code].downcase}",
            #title: printing[:edition_name]}
      end

      def self.card_score(html, dbs, card)
        return unless card[:card_scores].any?

        dbs.each do |db|
          score = card[:card_scores][db[:key]]
          next unless score

          html.tag('span', score.to_s,
                   class: 'badge badge-pill',
                   title: db[:name])
        end
      end

      def self.count_badge(html, count, force = false)
        return if !force && count == 1

        cls = 'badge badge-primary badge-pill'

        # FIXME: This is to add a space between the badge and the text
        html.append_html(' ')

        title = if count == 1
          '1 card'
        else
          "#{count} cards"
        end
        html.tag('span', count.to_s, class: cls, title: title)
      end

      def self.card_text(html, card)
        return unless card[:card_text]

        html.append_html('<div class="mtgText">')

        text = mtg_icons(card[:card_text])
        html.append_html(text.gsub("\n", "<br />"))

        html.append_html('<div>')
      end

      def self.mtg_icons(text)
        return unless text

        text = text.gsub(/{(\w+)}/) { mtg_icon($1.downcase) }
        text.gsub(/{(\w+)\/(\w+)}/) do
          mtg_double_icon($1.downcase, $2.downcase)
        end
      end

      def self.mtg_icon(icon)
        icon = ICON_MAP.fetch(icon, icon)

        %Q(<i class="ms ms-cost ms-#{icon}"></i>)
      end

      def self.mtg_icons_list(icons)
        return unless icons

        icons.map { |icon| mtg_icon(icon.downcase) }.join('')
      end

      def self.mtg_double_icon(icona, iconb)
        icon = "#{icona}#{iconb}"

        %Q(<i class="ms ms-cost ms-split ms-#{icon}"></i> )
      end

      def self.mtg_tags(html, tags)
        return unless tags

        tags.each do |tag|
          mtg_tag(html, tag)
        end
      end

      def self.mtg_tag(html, tag)
        icon = TAG_ICONS[tag]

        return html.append_html(mtg_icon(icon)) if icon

        html.append_html(
          %Q(<span class="mtgTag mtgTag--#{tag.downcase}">#{tag}</span> )
        )
      end

      def self.page(html, number, current, text = number.to_s)
        cls = 'page-item'
        cls << ' disabled' if number.nil?
        cls << ' active' if number == current

        html.tag('li', class: cls) do
          html.link("?page=#{number}", text, class: 'page-link')
        end
      end

      # TODO: Improve
      def self.pagination(html, current_page, total_pages)
        return if total_pages < 2 && current_page < 2

        if total_pages <= 7
          first_top = total_pages
        else
          first_top = [3, total_pages].min
        end

        html.tag('ul', class: 'pagination') do
          if current_page > 1
            page(html, current_page - 1, current_page, 'Prev')
          else
            page(html, nil, current_page, 'Prev')
          end

          (1..first_top).each do |i|
            page(html, i, current_page)
          end

          if first_top < total_pages
            last_start = [5, (total_pages - 2)].max

            if current_page < last_start && current_page > first_top
              page(html, current_page, current_page)
            end

            (last_start..total_pages).each do |i|
              page(html, i, current_page)
            end
          end

          if current_page < total_pages
            page(html, current_page + 1, current_page, 'Next')
          else
            page(html, nil, current_page, 'Next')
          end
        end
      end
    end
  end
end
