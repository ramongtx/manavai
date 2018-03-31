class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def wants
    @term = params[:term]
    @cards = @term.present? ? current_user.wanted_cards.search_by_name(@term) : current_user.wanted_cards
  end

  def haves
    @term = params[:term]
    @cards = @term.present? ? current_user.owned_cards.search_by_name(@term) : current_user.owned_cards
  end

  def list
    @updatable = params[:updatable]
    @cards = params[:list] == 'have' ? current_user.owned_cards : current_user.wanted_cards
    @cards = @cards.search_by_name(params[:term]) if params[:term].present?
    render 'shared/list_update'
  end
end
