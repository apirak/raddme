class UserMailer < ActionMailer::Base
  default from: "just@radd.me"

  def exchanged_unregistered(user, friend)
    setup_mail(user, friend)
  end

  def exchanged(user, friend)
    setup_mail(user, friend)
  end

  def setup_mail(user, friend)
    @user = user
    @friend = friend
    mail(:to => friend.email, :subject => "Here's #{@user.fullname} details on Radd.me")
  end
end
