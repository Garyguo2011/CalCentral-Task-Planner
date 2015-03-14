require "spec_helper"

describe SubtasksController do
  describe "routing" do

    it "routes to #index" do
      get("/tasks/1/subtasks").should route_to("subtasks#index", :task_id => '1')
    end

    it "routes to #new" do
      get("/tasks/1/subtasks/new").should route_to("subtasks#new", :task_id => '1')
    end

    it "routes to #show" do
      get("/tasks/1/subtasks/1").should route_to("subtasks#show", :task_id => '1', :id => "1")
    end

    it "routes to #edit" do
      get("/tasks/1/subtasks/1/edit").should route_to("subtasks#edit", :task_id => '1', :id => "1")
    end

    it "routes to #create" do
      post("/tasks/1/subtasks").should route_to("subtasks#create", :task_id => '1')
    end

    it "routes to #update" do
      put("/tasks/1/subtasks/1").should route_to("subtasks#update", :task_id => '1', :id => "1")
    end

    it "routes to #destroy" do
      delete("/tasks/1/subtasks/1").should route_to("subtasks#destroy", :task_id => '1', :id => "1")
    end

  end
end
