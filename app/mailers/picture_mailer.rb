class PictureMailer < ApplicationMailer
  def picture_mail(picture)
    @picture = picture
    mail to: "#{@picture.user.email}", subject: "Picture投稿時の確認メール"
  end
end
