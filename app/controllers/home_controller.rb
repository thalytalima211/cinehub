class HomeController < ApplicationController
  def index
    movies_scope = Movie.order(release_year: :desc)
                        .by_search(params[:search])
                        .by_year(params[:year])
                        .by_category(params[:category])
                        .by_director(params[:director])

    @categories = Category.all
    @directors = Director.all
    @pagy, @movies = pagy(movies_scope)
  end
end
