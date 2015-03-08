require "spec_helper"

describe SubtasksController do
  describe "routing" do

    it "routes to #index" do
      get("/subtasks").should route_to("subtasks#index")
    end

    it "routes to #new" do
      get("/subtasks/new").should route_to("subtasks#new")
    end

    it "routes to #show" do
      get("/subtasks/1").should route_to("subtasks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/subtasks/1/edit").should route_to("subtasks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/subtasks").should route_to("subtasks#create")
    end

    it "routes to #update" do
      put("/subtasks/1").should route_to("subtasks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/subtasks/1").should route_to("subtasks#destroy", :id => "1")
    end

  end
end
