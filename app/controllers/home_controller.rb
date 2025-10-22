class HomeController < ApplicationController
  def index
    movies_scope = Movie.order(release_year: :desc)

    @pagy, @movies = pagy(movies_scope)
  end
end
