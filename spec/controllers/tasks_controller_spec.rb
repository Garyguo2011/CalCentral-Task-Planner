require 'spec_helper'
require 'capybara/rspec'


describe TasksController, :type => :controller do
  before(:each) do
    login_user
  end

  it "should have a current_user" do
    subject.current_user.should_not be_nil
  end

  describe "GET index" do
    it "renders the index template" do
      get :index
      response.should be_success
      expect(response).to render_template("index")
    end
    it "can sort based on title" do
      get :index, :sort => 'title'
      response.should be_success
      expect(response).to render_template("index")
    end

    it "can filter based on type" do
      get :index, :filter => 'Project'
      response.should be_success
      expect(response).to render_template("index")
    end

    it "can show all finished tasks" do
      get :index, :show_finished => 'Finished'
      response.should be_success
      expect(response).to render_template("index")
    end

    it "can show all finished tasks and filter by Project" do
      get :index, :show_finished => 'Finished', :filter => 'Project'
      response.should be_success
      expect(response).to render_template("index")
    end

    it "renders the index template" do
      session[:sort] = 'title'  
      get :index
      response.should be_success
      expect(response).to render_template("index")
    end

    it "renders the index template" do
      session[:filter] = 'Project'  
      get :index
      response.should be_success
      expect(response).to render_template("index")
    end

    it "renders the index template" do
      get :index, :filter => 'Show All'
      response.should be_success
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    it "does not show a detailed task page" do
      task = FactoryGirl.build(:task)
      get :show, id: task.id
      response.should redirect_to('/')
    end

    it "shows a detailed task page" do
      task = FactoryGirl.create(:task, user: subject.current_user)
      get :show, id: task.id
      response.should be_success
      expect(response).to render_template('show')
    end
  end

  describe "POST create" do

    it "should save a users task into current_user" do
      task = subject.current_user.tasks.build(title: 'HW2')
      post :create, :task => {:title => 'Quiz#2', :course => 'CS169', :kind => 'Exam', :release => '12/Mar/2015 23:59:00 -0800', :due => '19/Mar/2015 23:59:00 -0800', :status => 'New', :rate => 3}
      subject.current_user.tasks.should include(task)
    end

    it "should stay in new page with incorrect attributes" do
      task = subject.current_user.tasks.build(title: 'HW2')
      post :create, :task => {:title => 'Quiz#2', :course => 'CS169', :kind => 'Exam', :release => '20/Mar/2015 23:59:00 -0800', :due => '19/Mar/2015 23:59:00 -0800', :status => 'New', :rate => 3}
      subject.current_user.tasks.should include(task)
    end

    it "should stay in new page with invalid rate" do
      task = subject.current_user.tasks.build(title: 'HW2')
      post :create, :task => {:title => 'Quiz#2', :course => 'CS169', :kind => 'Exam', :release => '18/Mar/2015 23:59:00 -0800', :due => '19/Mar/2015 23:59:00 -0800', :status => 'New', :rate => 0}
      subject.current_user.tasks.should include(task)
    end

    it "should get subtasks for a project prefilled" do
      task = subject .current_user.tasks.build(title: 'Project2')
      post :create, :task => {:title => 'Project2', :course => 'CS169', :kind => 'Project', :release => '18/Mar/2015 23:59:00 -0800', :due => '19/Mar/2015 23:59:00 -0800', :status => 'New', :rate => 1}, :needPrefill => 'yes'
      subject.current_user.tasks.should include(task)
    end

    it "should get subtasks for a paper prefilled" do
      task = subject .current_user.tasks.build(title: 'Essay1')
      post :create, :task => {:title => 'Essay1', :course => 'CS195', :kind => 'Paper', :release => '18/Mar/2015 23:59:00 -0800', :due => '19/Mar/2015 23:59:00 -0800', :status => 'New', :rate => 1}, :needPrefill => 'yes'
      subject.current_user.tasks.should include(task)
    end

    it "should get subtasks for an exam prefilled" do
      task = subject .current_user.tasks.build(title: 'Midterm1')
      post :create, :task => {:title => 'Midtern1', :course => 'CS169', :kind => 'Exam', :release => '18/Mar/2015 23:59:00 -0800', :due => '19/Mar/2015 23:59:00 -0800', :status => 'New', :rate => 1}, :needPrefill => 'yes'
      subject.current_user.tasks.should include(task)
    end

    it "should get subtasks for a homework prefilled" do
      task = subject .current_user.tasks.build(title: 'HW1')
      post :create, :task => {:title => 'HW1', :course => 'CS169', :kind => 'Homework', :release => '18/Mar/2015 23:59:00 -0800', :due => '19/Mar/2015 23:59:00 -0800', :status => 'New', :rate => 1}, :needPrefill => 'yes', :numProb => '4'
      subject.current_user.tasks.should include(task)
    end

    it "should create some trivial subtasks for other assignment" do
      task = subject .current_user.tasks.build(title: '??')
      post :create, :task => {:title => '??', :course => 'CS169', :kind => 'Other', :release => '18/Mar/2015 23:59:00 -0800', :due => '19/Mar/2015 23:59:00 -0800', :status => 'New', :rate => 1}, :needPrefill => 'yes'
      subject.current_user.tasks.should include(task)
    end    
  end

  describe 'GET #new' do
    it 'assigns a new task to Task' do
      get :new
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe "GET edit" do
    before(:each) do
      @task = FactoryGirl.create(:task)
      session[:current_user] = @task.user_id
      @current_user = User.find_by_id(session[:current_user]) if session[:current_user]
    end
    it "assigns the requested task as @task" do
      get :edit, {:id => @task.user_id}
      assigns(:task).should eq(@task)
    end
    it "can't assigns the requested task as @task" do
      task = Task.new(:title => "HW2", :course => "Computer Science 169", :status => "New", :kind => "Homework", :due => "2015-03-07 07:59:00", :release => "2015-03-03 07:59:00", :user_id => 2, :rate => 3)
      get :edit, {:id => task.user_id}
      response.should_not be_success
    end
  end

  describe "PUT update" do
    before(:each) do
      # User.stub(:find).returns(user)
      @task = FactoryGirl.create(:task)
      session[:current_user] = @task.user_id
      @current_user = User.find_by_id(session[:current_user]) if session[:current_user]
    end
    describe "with valid params" do
      it "updates the requested task" do
        @task.subtasks.create!(:description => 'trivial', :is_done => false, :task_id => @task.id)
        @task.title = 'HW4'
        @task.kind = 'Paper'
        put :update, {:id => @task.user_id, :task=> {:title => "HW2", :course => "Computer Science 169", :status => "New", :kind => "Paper", :due => "2015-03-07 07:59:00", :release => "2015-03-03 07:59:00", :user_id => 2, :rate => 3}, :needPrefill => 'yes'}
      end

      it "assigns the requested task as @task" do
        @task.title = 'HW4'
        put :update, {:id => @task.user_id}
        assigns(:task).should eq(@task)
      end

      it "redirects to the task" do
        @task.title = 'HW4'
        put :update, {:id => @task.user_id}
        response.should redirect_to(@task)
      end
      it "can't update" do
        put :update, {:id => @task.user_id}
        response.should_not be_success
      end
    end
    # Dev - Xinran Guo
    describe "with invalid params" do
      it "can't update" do
        mock_task ||= mock_model("Task", :update_attributes => false).as_null_object
        Task.stub(:find) { mock_task }
        put :update, {:id => @task.user_id}
        expect(response).to render_template("edit")
      end
    end
  end

  describe 'DELETE destroy' do
    it "deletes the task" do
      @task = FactoryGirl.create(:task, user: subject.current_user)
      expect{ delete :destroy, id: @task}.to change(Task, :count).by(-1)
    end
  end


  describe 'change status' do
    before (:each) do
      Time.stub(:now).and_return("5/Jan/2015 22:00:00 -0800".to_datetime)
    end
    it "change New status" do
      @task = FactoryGirl.create(:task, id: 10, status: "New")
      put :changestatus, :id => 10
      @task.reload
      expect(@task.status).to eq('Started')
    end

    it "change Started status" do
      @task = FactoryGirl.create(:task, id: 10, status: "Started")
      put :changestatus, :id => 10
      @task.reload
      #expect{ get :tasks, :id: 10, :format: 'status'}.to change(@task, :status).from('Started').to('Finished')
      expect(@task.status).to eq('Finished')
    end

    it "change Finished status" do
      @task = FactoryGirl.create(:task, id: 10, status: "Finished")
      put :changestatus, :id => 10
      @task.reload
      #expect{ get :tasks, :id: 10, :format: 'status'}.to change(@task, :status).from('Started').to('Finished')
      expect(@task.status).to eq('Started')
    end

    it "change Past due status" do
      @task = FactoryGirl.create(:task, id: 10, status: "Past due")
      put :changestatus, :id => 10
      @task.reload
      #expect{ get :tasks, :id: 10, :format: 'status'}.to change(@task, :status).from('Started').to('Finished')
      expect(@task.status).to eq('Finished')
    end
  end

  describe "GET status" do
    it "renders the status template" do
      get :status
      response.should be_success
      expect(response).to render_template("status")
    end
    it "can sort based on title" do
      get :status, :sort => 'title'
      response.should be_success
      expect(response).to render_template("status")
    end

    it "can filter based on type" do
      get :status, :filter => 'Project'
      response.should be_success
      expect(response).to render_template("status")
    end

    it "can show all finished tasks" do
      get :status, :show_finished => 'Finished'
      response.should be_success
      expect(response).to render_template("status")
    end

    it "can show all finished tasks and filter by Project" do
      get :status, :show_finished => 'Finished', :filter => 'Project'
      response.should be_success
      expect(response).to render_template("status")
    end

    it "renders the status template" do
      session[:sort] = 'title'  
      get :status
      response.should be_success
      expect(response).to render_template("status")
    end

    it "renders the status template" do
      session[:filter] = 'Project'  
      get :status
      response.should be_success
      expect(response).to render_template("status")
    end

    it "renders the status template" do
      get :status, :filter => 'Show All'
      response.should be_success
      expect(response).to render_template("status")
    end
  end
end