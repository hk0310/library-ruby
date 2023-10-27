class SearchController < ApplicationController
  def results
    @query = params[:q]

    if params[:author].present?
      @author = Author.find(params[:author])
      @books = @author.books.where('title LIKE ?', "%#{@query}%")
    else
      @books = Book.where('title LIKE ?', "%#{@query}%")
    end
  end
end
