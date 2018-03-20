Fabricator(:card, aliases: [:land_card]) do
  layout 'normal'
  name 'Plains'
  names nil
  mana_cost "{R}{R}"
  converted_mana_cost 2
  colors ["R"]
  color_identity ["R"]
  type "Basic Land \u2014 Plains"
  supertypes ['Basic']
  types ['Land']
  subtypes ['Plains']
  power 3
  toughness 3
  loyalty 2
  text 'some text'
end
