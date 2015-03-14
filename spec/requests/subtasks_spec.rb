require 'spec_helper'

describe "Subtasks" do
  before(:each) do
    login_user
  end

  describe "GET /subtasks" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get task_subtasks_path(:task_id => 1)
      response.status.should be(200)
    end
  end
end
