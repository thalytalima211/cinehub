class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_locale

  private
  def set_locale
    I18n.locale = params[:locale] || cookies[:locale] || I18n.default_locale
    cookies[:locale] = I18n.locale
  end

  def default_url_options
    {}
  end
end
