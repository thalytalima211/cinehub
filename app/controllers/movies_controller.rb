class MoviesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :set_collections, only: %i[new create edit update]
  before_action :check_owner, only: %i[edit update]

  def show
    @movie = Movie.find(params[:id])
    @comments = @movie.comments.order(created_at: :desc)
  end

  def new
    @movie = Movie.new
  end

  def edit; end

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

  def update
    ActiveRecord::Base.transaction do
      @movie.assign_attributes(movie_params)
      assign_associations
      @movie.save!
    end

    redirect_to @movie, notice: t('notices.movie.updated')
  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = t('alerts.movie.not_updated')
    render :edit, status: :unprocessable_content
  end

  private

  def set_movie
    @movie = Movie.find params[:id]
  end

  def check_owner
    set_movie
    return unless current_user != @movie.user

    redirect_to root_path, alert: t('alerts.movie.update_not_allowed')
  end

  def movie_params
    params.require(:movie).permit(:poster, :title, :description, :release_year, :duration, :category_id)
  end

  def set_collections
    @directors = Director.all
    @categories = Category.all
    @tags = Tag.all
  end

  def assign_associations
    assign_director
    assign_tags
  end

  def assign_director
    director_name = params[:movie][:director].to_s.strip

    @movie.director = if director_name.blank?
                        nil
                      else
                        Director.find_or_create_by!(name: director_name)
                      end
  end

  def assign_tags
    return if params[:movie][:tag_ids].blank?

    ids = params[:movie][:tag_ids].compact_blank
    @movie.tags = Tag.where(id: ids)
  end
end
