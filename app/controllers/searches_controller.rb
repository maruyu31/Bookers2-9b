class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "User"
      @records = User.looks(params[:search], params[:word])
    else
      @records = Book.looks(params[:search], params[:word])
    end
  end
end
