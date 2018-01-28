module Helpers
  module MTGHelper
    TAG_ICONS = {
      'Island' => 'U',
      'Forest' => 'G',
      'Mountain' => 'R',
      'Plains' => 'W',
      'Swamp' => 'B'
    }.freeze

    def import_cards_count(printing)
      count = printing[:user_printing_count]

      %Q(<span class="badge badge-primary badge-pill"
               title="#{count} cards on this import">#{count}</span>)
    end

    def mtg_icon(icon)
      %Q(<i class="mtgIcon mtgIcon--#{icon}">{#{icon}}</i>)
    end

    def mtg_icons(text)
      return unless text

      text.gsub(/{(\w+)}/) { mtg_icon($1) }
    end

    def mtg_icons_list(icons)
      return unless icons

      icons.map { |icon| mtg_icon(icon) }.join('')
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
