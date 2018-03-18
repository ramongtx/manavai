class CardsController < ApplicationController
  before_action :authenticate_user!, except: %i[index list card]

  def index
    @term = params[:term]
    @cards = Card.search_by_name(@term)
  end

  def list
    @updatable = params[:updatable]
    @cards = Card.search_by_name(params[:term])
  end

  def want
    @card = Card.find(params[:id])
    if current_user.wanted_cards.include?(@card)
      current_user.want_list.where(card: @card).destroy_all
    else
      current_user.wanted_cards << @card
    end
  end

  def have
    @card = Card.find(params[:id])
    if current_user.owned_cards.include?(@card)
      current_user.have_list.where(card: @card).destroy_all
    else
      current_user.owned_cards << @card
    end
  end
end
