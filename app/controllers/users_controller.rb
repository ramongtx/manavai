class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(username: params[:id])
    @wanted_cards = @user.wanted_cards
    @owned_cards = @user.owned_cards
  end
end
