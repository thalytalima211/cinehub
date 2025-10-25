class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: %i[show update]

  def show
    @user = current_user
    movies_scope = @user.movies.order(release_year: :desc)

    @pagy, @movies = pagy(movies_scope)
  end

  def update
    @user = current_user

    case params[:update_type]
    when 'profile'
      update_profile
    when 'password'
      update_password
    end
  end

  private

  def update_profile
    if @user.update_without_password(user_params)
      redirect_to profile_path, notice: t('notices.user.updated')
    else
      @movies = @user.movies
      flash.now[:alert] = t('alerts.user.not_updated')
      render :show, status: :unprocessable_content
    end
  end

  def update_password
    if @user.update_with_password(password_params)
      bypass_sign_in(@user)
      redirect_to profile_path, notice: t('notices.user.password_updated')
    else
      @movies = @user.movies
      render :show, status: :unprocessable_content
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :profile_picture)
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
