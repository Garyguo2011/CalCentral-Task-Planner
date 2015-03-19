require 'spec_helper'
require 'capybara/rspec'
require 'pp'


describe SubtasksController, :type => :controller do

  before(:each) do
    login_user
    @task = mock_model(Task)
    @subtask = mock_model(Subtask)
    @subtasks = double("subtasks")
    @task.stub(:subtasks).and_return(@subtasks)
    @task.stub(:user_id).and_return(@user)
    @subtask.stub(:task).and_return(@task)
    
    Subtask.stub(:find).and_return(@subtask)
    @subtasks.stub(:find).and_return(@subtask)
    @subtasks.stub(:build).and_return(@subtask)
    @subtasks.stub(:create).and_return(@subtask)
    Task.stub(:find).and_return(@task)
    Task.stub(:accessible_by).and_return(Task)
  end

  describe "GET index" do
    it "shoud rediect to the task path" do
      get :index, :task_id => '9'
      expect(response).to be_success
      expect(response).to render_template('index')
    end
  end

  describe "GET show" do
    it "should show the show path" do
      subtask = FactoryGirl.build(:subtask)
      get :show, {:task_id => 1, :id => subtask.id}
      # Subtask.should_receive(:find).with(1).and_return(@task)
      expect(response).to be_success
      expect(response).to render_template('show')
    end
  end

  describe "GET new" do
    it "should show the " do
      get :new, {:task_id => 1}
      # Subtask.should_receive(:find).with(1).and_return(@task)
      expect(response).to be_success
      expect(response).to render_template('new')
    end
  end

  describe "GET edit" do
    it "should show the " do
      subtask = FactoryGirl.build(:subtask)
      get :edit, {:task_id => 1, :id => subtask.id}
      # Subtask.should_receive(:find).with(1).and_return(@task)
      expect(response).to be_success
      expect(response).to render_template('edit')
    end
  end

  describe "POST create" do
    # before(:each) do
      # User.stub(:find).returns(user)
      # @task = FactoryGirl.create(:task)
      # session[:current_user] = @task.user_id
      # @current_user = User.find_by_id(session[:current_user]) if session[:current_user]
    # end

    it "should save a users subtask into current_task" do
      @subtask.stub(:save).and_return(@task)
      post :create, {:task_id => @task.id, :subtask => {:id => 1, :description => 'how to create a model', :is_done => false, :task_id => 1}}
      expect(response).to redirect_to(task_url(assigns(:task)))
    end

    it "should redirect to new page and show error message" do
      @subtask.stub(:save).and_return(false)
      post :create, {:task_id => @task.id, :subtask => {:id => 1, :description => '', :is_done => false, :task_id => 1}}
      expect(response).to render_template('new')
    end
  end

  describe "POST update" do
    it "should save a users subtask into current_task" do
      @subtask.stub(:update_attributes).and_return(@subtask)
      put :update, {:task_id => @task.id, :id => @subtask.id, :subtask => {:id => 1, :description => 'how to create a model', :is_done => false, :task_id => 1}}
      expect(response).to redirect_to(task_url(assigns(:task)))
    end

    it "should redirect to edit page when attribute not legal" do
      @subtask.stub(:update_attributes).and_return(false)
      put :update, {:task_id => @task.id, :id => @subtask.id, :subtask => {:id => 1, :description => '', :is_done => false, :task_id => 1}}
      expect(response).to render_template('edit')
    end
  end

  describe "DELETE delete" do
    it "should save a users subtask into current_task" do
      delete :destroy, {:task_id => @task.id, :id => @subtask.id}
      expect(response).to redirect_to(task_url(assigns(:task)))
    end
  end
end
