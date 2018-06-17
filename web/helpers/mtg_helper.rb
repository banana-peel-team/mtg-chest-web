module Web
  module Helpers
    module MTGHelper
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

      def gatherer_url(printing)
        "http://gatherer.wizards.com/" +
          "Pages/Card/Details.aspx?multiverseid=#{printing[:multiverse_id]}"
      end

      def gatherer_link(printing)
        return unless printing[:multiverse_id]
        haml_tag(:a, target: '_blank', href: gatherer_url(printing)) do
          haml_icon('share-square')
        end
      end

      def card_text(card)
        return unless card[:card_text]

        text = mtg_icons(card[:card_text])
        text = text.gsub("\n", "<br />")

        %Q(<div class="mtgText">#{text}</div>)
      end

      def mtg_icon(icon)
        icon = ICON_MAP.fetch(icon, icon)

        %Q(<i class="ms ms-cost ms-#{icon}"></i>)
      end

      def mtg_double_icon(icona, iconb)
        icon = "#{icona}#{iconb}"

        %Q(<i class="ms ms-cost ms-split ms-#{icon}"></i>)
      end

      def mtg_icons(text)
        return unless text

        text = text.gsub(/{(\w+)}/) { mtg_icon($1.downcase) }
        text.gsub(/{(\w+)\/(\w+)}/) do
          mtg_double_icon($1.downcase, $2.downcase)
        end
      end

      def mtg_icons_list(icons)
        return unless icons

        icons.map { |icon| mtg_icon(icon.downcase) }.join('')
      end

      def mtg_tags(tags)
        return unless tags

        tags.map do |tag|
          mtg_tag(tag)
        end.join(' ')
      end

      def mtg_tag(tag)
        icon = TAG_ICONS[tag]
        return mtg_icon(icon) if icon

        %Q(<span class="mtgTag mtgTag--#{tag.downcase}">#{tag}</span>)
      end
    end
  end
end
