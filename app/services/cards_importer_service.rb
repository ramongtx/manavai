class CardsImporterService
  def self.import(set = nil)
    page = 1
    loop do
      break if save_page(set, page).zero?
      page += 1
    end
  end

  def self.save_page(set = nil, page = 1)
    query = MTG::Card
    query = query.where(set: set) if set.present?
    next_cards = query.where(page: page, pageSize: 500).all
    next_cards.each { |card| Card.create_or_update_from(card) }
    next_cards.count
  end
end
