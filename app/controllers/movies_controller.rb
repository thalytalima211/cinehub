class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @comments = @movie.comments.order created_at: :desc
  end
end
