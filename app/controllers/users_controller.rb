class UsersController < ApplicationController
  before_action :extract_params

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(username: params[:id])
    @wanted_cards = @user.wanted_cards
    @owned_cards = @user.owned_cards
  end

  def wants
    @user = User.find_by(username: params[:id])
    @list_type = 'want'
    find_cards
  end

  def haves
    @user = User.find_by(username: params[:id])
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
    @cards = @list_type == 'have' ? @user.owned_cards : @user.wanted_cards
    @cards = @cards.search_by_name(@term) if @term.present?
  end
end
