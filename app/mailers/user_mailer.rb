class UserMailer < ActionMailer::Base
  default from: "notification2015taskplanner@gmail.com"

  def task_notification(user)
  	@message = user.tasks.generate_message
  	if user.email_notifications != "never"
  		mail(:to => user.email, :subject => "Summary of your unfinished Tasks")
  	end
  	return @message
  end

  def task_create_confirmation(user)
  	if user.email_notifications != "never"
  		mail(:to => user.email, :subject => "Task Created")
  	end
  end

  def task_update_confirmation(user)
  	if user.email_notifications != "never"
  		mail(:to => user.email, :subject => "Task Updated")
  	end
  end
end
