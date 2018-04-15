class CardsController < ApplicationController
  before_action :authenticate_user!, except: %i[index list]
  before_action :extract_params
  before_action :find_cards, only: %i[index list]
  before_action :find_single_card, only: %i[want have]

  def index; end

  def list
    render 'shared/list_update'
  end

  def want
    if current_user.wanted_cards.include?(@card)
      current_user.want_list.where(card: @card).destroy_all
    else
      current_user.wanted_cards << @card
    end
    render 'shared/card_update'
  end

  def have
    if current_user.owned_cards.include?(@card)
      current_user.have_list.where(card: @card).destroy_all
    else
      current_user.owned_cards << @card
    end
    render 'shared/card_update'
  end

  private

  def extract_params
    @updatable_list = params[:updatable_list]
    @updatable_album = params[:updatable_album]
    @term = params[:term]
  end

  def find_cards
    @cards = Card.search_by_name(@term)
  end

  def find_single_card
    @card = Card.find(params[:id])
  end
end
