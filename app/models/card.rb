class Card < ApplicationRecord
  include PgSearch

  CARD_PROPS = %i[name colors color_identity type rarity text power toughness mana_cost names].freeze
  PRINTING_PROPS = %i[set image_url multiverse_id id].freeze

  pg_search_scope :search_by_name, against: %i[name portuguese_name], ignoring: :accents,
                                   using: { tsearch: { prefix: true, negation: true } },
                                   ranked_by: 'name'

  def self.create_or_update_from(mtg_card)
    new_card = find_or_initialize_by(name: mtg_card.name)
    new_card.update_props_from(mtg_card)
    new_card.update_printings_from(mtg_card)
    new_card.save!
  end

  def update_props_from(mtg_card)
    portuguese_details = mtg_card.foreign_names&.select { |fn| fn.language == 'Portuguese (Brazil)' }&.first
    props = CARD_PROPS.map { |prop| [prop, mtg_card.send(prop)] }.to_h
    props = props.merge(portuguese_name: portuguese_details.name) if portuguese_details.present?
    update_attributes(props)
  end

  def update_printings_from(mtg_card)
    portuguese_details = mtg_card.foreign_names&.select { |fn| fn.language == 'Portuguese (Brazil)' }&.first
    new_printing = PRINTING_PROPS.map { |prop| [prop, mtg_card.send(prop)] }.to_h
    new_printing = new_printing.merge(portuguese_mid: portuguese_details.multiverse_id) if portuguese_details.present?
    add_printing(new_printing)
  end

  def add_printing(printing)
    self.printings |= []
    self.printings.delete_if { |p| p['id'] == printing[:id] }
    self.printings << printing
  end

  def self.inheritance_column
    :inheritance_type
  end
end
