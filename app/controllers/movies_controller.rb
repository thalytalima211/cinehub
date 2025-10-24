class MoviesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :set_collections, only: %i[new create]

  def show
    @movie = Movie.find(params[:id])
    @comments = @movie.comments.order(created_at: :desc)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user

    ActiveRecord::Base.transaction do
      assign_associations
      @movie.save!
    end

    redirect_to @movie, notice: t('notices.movie.created')
  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = t('alerts.movie.not_created')
    render :new, status: :unprocessable_content
  end

  private

  def movie_params
    params.require(:movie).permit(:poster, :title, :description, :release_year, :duration, :category_id)
  end

  def set_collections
    @directors = Director.all
    @categories = Category.all
  end

  def assign_associations
    assign_director
    assign_tags
  end

  def assign_director
    return if params[:movie][:director].blank?

    @movie.director = Director.find_or_create_by!(name: params[:movie][:director].strip)
  end

  def assign_tags
    return if params[:movie][:tag_ids].blank?

    ids = params[:movie][:tag_ids].compact_blank
    @movie.tags = Tag.where(id: ids)
  end
end
