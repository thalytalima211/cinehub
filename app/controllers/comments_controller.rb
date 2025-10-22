class CommentsController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.new(comment_params)
    @comment.user = current_user if user_signed_in?

    if @comment.save
      redirect_to @movie, notice: t('notices.comment.created')
    else
      flash.now[:alert] = t('alerts.comment.not_created')
      @comments = @movie.comments.includes(:user)
      render 'movies/show', status: :unprocessable_content
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:username, :content, :rating)
  end
end
