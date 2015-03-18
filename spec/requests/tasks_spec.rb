require 'spec_helper'

describe "Tasks" do
  describe "GET /tasks" do
    it "should redirect when user not login" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get tasks_path
      response.status.should be(302)
    end
  end
end
