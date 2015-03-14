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
    Task.stub(:find).and_return(@task)
    @subtask.stub(:task).and_return(@task)
    @subtask.stub(:save).and_return(@task)
    Subtask.stub(:find).and_return(@subtask)
    @subtasks.stub(:find).and_return(@subtask)
    @subtasks.stub(:build).and_return(@subtask)
    @subtasks.stub(:create).and_return(@subtask)
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
    before(:each) do
      @task = FactoryGirl.create(:user)
    it "should save a users subtask into current_task" do
      post :create, {:task_id => 1, :subtask => {:id => 1, :description => 'how to create a model', :is_done => false, :task => nil}}
      expect(response).to be_success
      # subject.current_user.subtasks.should include(:subtask)
    end

    # it "should stay in new page with incorrect attributes" do
    #   post :create, :task => {:title => 'Quiz#2', :course => 'CS169', :kind => 'Exam', :release => '20/Mar/2015 23:59:00 -0800', :due => '19/Mar/2015 23:59:00 -0800', :status => 'New'}
    #   subject.current_user.tasks.should include(task)
    # end
  end

end



