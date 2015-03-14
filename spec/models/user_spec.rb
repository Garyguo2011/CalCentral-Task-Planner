require 'spec_helper'

describe User do
	before(:each) do
		@user = FactoryGirl.create(:user, :email => "aaa@aaa.com", :first_name => "J", :last_name => "Z")
	end
	describe "full name" do
		it "should be a full name" do
			@user.full_name.should eq("J Z")
		end
	end
end
