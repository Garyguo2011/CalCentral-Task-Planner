require 'spec_helper'

describe "Subtasks" do
  describe "GET /tasks/:id/Subtasks" do
    it "should redirect when user not login" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get task_subtasks_path(:task_id => 1)
      response.status.should be(302)
    end
  end
end
