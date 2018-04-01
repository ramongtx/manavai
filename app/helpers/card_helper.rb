module CardHelper
  def card_types_icon(card)
    types = card.type.split(' ').map(&:downcase) & %w[land creature instant sorcery planeswalker enchantment artifact]
    types.map { |type| "ms-#{type}" }
  end
end
