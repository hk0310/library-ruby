class GenresController < ApplicationController
  def index
    @genres = Genre.includes(:books).all
  end

  def show
    @genre = Genre.find(params[:id])
    @books = @genre.books
  end
end
