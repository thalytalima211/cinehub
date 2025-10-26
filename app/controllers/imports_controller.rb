class ImportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @imports = current_user.imports.order(created_at: :desc)
  end

  def new
    @import = Import.new
  end

  def create
    @import = build_import

    if @import.save
      MovieImportJob.perform_later(@import.id)
      redirect_to imports_path, notice: t('movie_import.create.success')
    else
      flash.now[:alert] = @import.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def import_params
    params.fetch(:import, {}).permit(:file)
  end

  def build_import
    import = Import.new(import_params)
    import.user = current_user
    import
  end
end
