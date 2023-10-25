class BooksController < ApplicationController
  def index
    @books = Book.includes(:authors).order(:title).page(params[:page]).per(20)
  end

  def show
    @book = Book.find(params[:id])
  end
end
