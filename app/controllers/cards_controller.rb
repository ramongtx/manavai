class CardsController < ApplicationController
    def index
        @term = params[:term]
        @cards = MTG::Card.where(name: @term).where(pageSize: 10).where(page: 1).all
    end
end