class CardsController < ApplicationController
  def index
    @term = params[:term]
    @cards = Card.search_by_name(@term)
  end
end
