class UsersController < ApplicationController
  before_action :extract_params

  def index
    @users = User.all
  end

  def show
    @wanted_cards = @user.wanted_cards
    @owned_cards = @user.owned_cards
  end

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
    @updatable_list = params[:updatable_list]
    @updatable_album = params[:updatable_album]
    @term = params[:term]
    @list_type = params[:list]
    @user = User.find_by(username: params[:id])
  end

  def find_cards
    @cards = @list_type == 'have' ? @user.owned_cards : @user.wanted_cards
    @cards = @cards.search_by_name(@term) if @term.present?
  end
end
