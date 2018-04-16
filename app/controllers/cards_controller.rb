class CardsController < ApplicationController
  before_action :authenticate_user!, except: %i[index album]
  before_action :extract_params
  before_action :find_cards, only: %i[index album]
  before_action :find_single_card, only: %i[want have]

  def index; end

  def album
    render 'shared/album_update'
  end

  def want
    if current_user.wanted_cards.include?(@card)
      current_user.want_album.where(card: @card).destroy_all
    else
      current_user.wanted_cards << @card
    end
    render 'shared/card_update'
  end

  def have
    if current_user.owned_cards.include?(@card)
      current_user.have_album.where(card: @card).destroy_all
    else
      current_user.owned_cards << @card
    end
    render 'shared/card_update'
  end

  private

  def extract_params
    @updatable_album = params[:updatable_album]
    @search = params[:search]
  end

  def find_cards
    @cards = Card.search_by_name(@search).limit(30)
  end

  def find_single_card
    @card = Card.find(params[:id])
  end
end
