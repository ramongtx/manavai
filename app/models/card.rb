class Card < ApplicationRecord
  IMPORTABLE_PROPS = %i[name colors color_identity type rarity set text power toughness multiverse_id image_url
                        mana_cost names].freeze

  def self.create_or_update_from(mtg_card)
    new_card = find_or_initialize_by(mtg_id: mtg_card.id)
    new_card.update_from_mtg_card(mtg_card)
    new_card.save!
  end

  def update_from_mtg_card(mtg_card)
    portuguese_details = mtg_card.foreign_names&.select { |fn| fn.language == 'Portuguese (Brazil)' }&.first
    props = IMPORTABLE_PROPS.map do |prop|
      [prop, mtg_card.send(prop)]
    end.to_h
    if portuguese_details.present?
      props = props.merge(portuguese_name: portuguese_details.name, portuguese_mid: portuguese_details.multiverse_id)
    end
    update_attributes(props)
  end

  def self.inheritance_column
    :inheritance_type
  end
end
