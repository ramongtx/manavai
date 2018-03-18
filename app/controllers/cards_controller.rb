class CardsController < ApplicationController
  def index
    @term = params[:term]
    @cards = Card.search_by_name(@term)
  end

  def list
    @updatable = params[:updatable]
    @cards = Card.search_by_name(params[:term])
  end
end
