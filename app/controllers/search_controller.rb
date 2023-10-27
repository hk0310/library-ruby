class SearchController < ApplicationController
  def results
    @query = params[:q]

    @books = Book.where('name LIKE ?', "%#{query}%")
  end
end
