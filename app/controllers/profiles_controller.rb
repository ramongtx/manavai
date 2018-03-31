class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :extract_params

  def wants
    @list_type = 'want'
    find_cards
  end

  def haves
    @list_type = 'have'
    find_cards
  end

  def list
    find_cards
    render 'shared/list_update'
  end

  private

  def extract_params
    @updatable = params[:updatable]
    @term = params[:term]
    @list_type = params[:list]
  end

  def find_cards
    @cards = @list_type == 'have' ? current_user.owned_cards : current_user.wanted_cards
    @cards = @cards.search_by_name(@term) if @term.present?
  end
end
