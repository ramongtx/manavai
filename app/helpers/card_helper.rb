module CardHelper
  def card_types_icon(card)
    types = card.type.split(' ').map(&:downcase) & %w[land creature instant sorcery planeswalker enchantment artifact]
    types.map { |type| "ms-#{type}" }
  end

  def card_costs_icon(card)
    return [] if card.mana_cost.blank?
    card.mana_cost.scan(/\{([^\{\}]+)\}/).map do |cost|
      cost = cost.first.downcase
      cost.sub!('/', '')
      if cost.length == 2 && !cost.include?('p')
        "ms-cost ms-shadow ms-split ms-#{cost.downcase}"
      else
        "ms-cost ms-shadow ms-#{cost.downcase}"
      end
    end
  end
end
