class UserMailer < ActionMailer::Base
  default from: "notification@ibearhost.com"

  def task_confirmation(user)
  	@message = user.tasks.generate_message
  	mail(:to => user.email, :subject => "Summary of your unfinished Tasks")
  	return @message
  end
end
