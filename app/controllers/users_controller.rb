class UsersController < ApplicationController
  before_action :extract_params

  def index
    @users = User.all
  end

  def show; end

  def wants
    @list_type = 'want'
    find_cards
  end

  def haves
    @list_type = 'have'
    find_cards
  end

  private

  def extract_params
    @updatable_list = params[:updatable_list]
    @updatable_album = params[:updatable_album]
    @search = params[:search]
    @user = User.find_by(username: params[:id])
  end

  def find_cards
    @cards = @list_type == 'have' ? @user.owned_cards : @user.wanted_cards
    @cards = @cards.search_by_name(@search) if @search.present?
  end
end
