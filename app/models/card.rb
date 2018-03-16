class Card < MTG::Card
  def self.search(name)
    where(name: name).where(language: 'Portuguese (Brazil)', pageSize: 10, page: 1).all
  end
end
