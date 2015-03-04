class TasksController < ApplicationController
  

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    id = params[:id]
    @task = Task.find(id)
  end

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    # default: reader 'new' template
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.create!(params[:task])
    flash[:notice] = "#{@task.title} was successfully updated."
    redirect_to tasks_path
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end


  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])
    @task.update_attributes!(params[:task])
    flash[:notice] = "#{@task.title} was successfully updated."
    redirect_to task_path(@task)
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = "#{@task.title} was successfully deleted."
    redirect_to tasks_path
  end
end
