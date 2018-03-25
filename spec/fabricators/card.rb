Fabricator(:card) do
  layout 'normal'
  name 'Super Card'
  names nil
  mana_cost "{R}{R}"
  converted_mana_cost 2
  colors ["R"]
  color_identity ["R"]
  type "Supertype  \u2014 Card"
  supertypes ['Supertype']
  types ['Type']
  subtypes ['Subtype']
  power 3
  toughness 3
  loyalty 2
  text 'some text'
end

Fabricator(:creature_card, from: :card) do
  name 'Rakdos Drake'
  names nil
  mana_cost "{2}{B}"
  converted_mana_cost 3.0
  colors ["B"]
  color_identity ["B"]
  type "Creature \u2014 Drake"
  supertypes nil
  types ['Creature']
  subtypes ['Drake']
  power 1
  toughness 2
  loyalty nil
  text "Flying\nUnleash (You may have this creature enter the " +
       "battlefield with a +1/+1 counter on it. It can't block " +
       "as long as it has a +1/+1 counter on it.)"
end

Fabricator(:basic_land_card, from: :card) do
  name 'Plains'
  names nil
  mana_cost nil
  converted_mana_cost 0.0
  colors nil
  color_identity ["W"]
  type "Basic Land \u2014 Plains"
  supertypes ['Basic']
  types ['Land']
  subtypes ['Plains']
  power nil
  toughness nil
  loyalty nil
  text nil
end
