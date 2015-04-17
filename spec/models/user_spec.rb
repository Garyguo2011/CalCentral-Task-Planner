require 'spec_helper'

describe User do
	before(:each) do
		@user = FactoryGirl.create(:user, :email => "aaa@aaa.com", :first_name => "J", :last_name => "Z", :email_notifications => "hourly")
		@user1 = {:email => "bbb@bbb.com", :password => "12345678", :first_name => "J", :last_name => "Z", :email_notifications => "hourly"}

		User.create!(@user1)
	end
	describe "full name" do
		it "should be a full name" do
			@user.full_name.should eq("J Z")
		end
	end
	describe "email config" do
		it "should return the time span accordingly" do
			@user.email_config.should eq(60.minutes)
		end
		it "should return one day" do
			@user["email_notifications"] = "daily"
			@user.email_config.should eq(1.day)
		end
	end

	describe "test email" do
		it "should deliver properly" do
			User.test_mail.should == "success"
		end
	end

end
