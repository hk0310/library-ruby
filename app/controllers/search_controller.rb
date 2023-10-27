class SearchController < ApplicationController
  def results
    @query = params[:q]

    @books = Book.where('title LIKE ?', "%#{@query}%")
  end
end
