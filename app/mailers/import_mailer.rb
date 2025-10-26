class ImportMailer < ApplicationMailer
  def notify_user
    @import = params[:import]
    mail(to: @import.user.email, subject: t('movie_import.mail.subject'))
  end
end
