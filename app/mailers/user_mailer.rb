class UserMailer < ActionMailer::Base
  default from: "notification@ibearhost.com"

  def task_notification(user)
  	@message = user.tasks.generate_message
  	mail(:to => user.email, :subject => "Summary of your unfinished Tasks")
  	return @message
  end

  def task_create_confirmation(user)
  	mail(:to => user.email, :subject => "Task Created")
  end

  def task_update_confirmation(user)
  	mail(:to => user.email, :subject => "Task Updated")
  end
end
