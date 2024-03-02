class PostMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.new_post_email.subject
  #
  def new_post_email(user, post)
    @title = "Your Post Email"
    @user = user
    @post = post

    mail(
      to: @user.email,
      subject: "New Post on #{post.title}"
    )
  end
end
