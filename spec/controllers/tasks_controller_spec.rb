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
				@task.title = 'HW4'
				put :update, {:id => @task.user_id}
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
end