require "spec_helper"
require	"pp"

describe UserMailer do
	before(:each) do
		# @user = FactoryGirl.create(:user, :email => "aaa@aaa.com", :first_name => "J", :last_name => "Z", :email_notifications => "hourly", :id => 1)
		@user = {:email => "aaa@aaa.com", :password => "12345678", :first_name => "J", :last_name => "Z", :email_notifications => "hourly"}

		User.create!(@user)
		@tasks =[
	      {:title => 'Midterm1', :course => 'CS164', :kind => 'Exam', :release => '4/Mar/2015 23:59:00 -0800', :due => '6/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 1, :rate => 3},
	      {:title => 'Homework5', :course => 'CS169', :kind => 'Homework', :release => '9/Mar/2015 23:59:00 -0800', :due => '16/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 1, :rate => 3},
	      {:title => 'Project2', :course => 'CS164', :kind => 'Project', :release => '9/Mar/2015 23:59:00 -0800', :due => '31/Mar/2015 23:59:00 -0800', :status => 'Started', :user_id => 1, :rate => 3},
	      {:title => 'Project3', :course => 'CS164', :kind => 'Project', :release => '9/Mar/2015 23:59:00 -0800', :due => '31/Mar/2015 23:59:00 -0800', :status => 'Finished', :user_id => 1, :rate => 3}
	    ]
	    @tasks.each do |task|
	      Task.create!(task)
	    end



	    # pp Task.all

	end
 	
 	describe "send email successfully" do
 		it "shoud send notification" do
 			mail = UserMailer.task_notification(User.first)
 			mail.to.should == [User.first.email]
 			mail.from.should == ["notification@ibearhost.com"]
 		end

 		it "should send email confirmation for create" do
 			mail = UserMailer.task_create_confirmation(User.first)
 			mail.to.should == [User.first.email]
 			mail.from.should == ["notification@ibearhost.com"]
 		end
 		it "should send email confirmation for update" do
 			mail = UserMailer.task_update_confirmation(User.first)
 			mail.to.should == [User.first.email]
 			mail.from.should == ["notification@ibearhost.com"]
 		end

 	end
end
