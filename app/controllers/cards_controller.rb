class CardsController < ApplicationController
  def index
    @term = params[:term]
    @cards = Card.search(@term)
  end
end
