class UserMailer < ActionMailer::Base
  default from: "notification@ibearhost.com"

  def task_confirmation(user)
  	mail(:to => user.email, :subject => "You registered")
  end
end
