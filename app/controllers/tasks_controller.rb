class TasksController < ApplicationController
  #load_and_authorize_resource

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.accessible_by(current_ability)
    if params[:sort] != nil
      sort_argument = params[:sort]
      session[:sort] = sort_argument
    elsif session[:sort] != nil
      sort_argument = session[:sort]
    else
      sort_argument = :status
      session[:sort] = sort_argument
    end
    #@tasks = Task.where("status != ?", "Finished").order(sort_argument).find_all_by_user_id(current_user)
    if params[:filter] != nil and params[:filter] != "Show All"
      filter_argument = params[:filter]
      session[:filter] = filter_argument
    elsif params[:filter] == nil
      if session[:filter] == nil
        filter_argument = nil
      else
        filter_argument = session[:filter]
      end
    else
      filter_argument = nil
      session[:filter] = filter_argument
    end
    if params[:show_finished] != nil
      show_finished = "Finished"
    else
      show_finished = nil
    end

    if filter_argument == nil and show_finished == nil
      @tasks = Task.where("status != ? AND user_id = ?", "Finished", current_user).order(sort_argument)
    elsif filter_argument != nil and show_finished != nil
      @tasks = Task.where("user_id = ?", current_user).order(sort_argument).find_all_by_kind(filter_argument)
    elsif filter_argument != nil
      @tasks = Task.where("status != ? AND user_id = ?", "Finished", current_user).order(sort_argument).find_all_by_kind(filter_argument)
    else
      @tasks = Task.where("user_id = ?", current_user).order(sort_argument)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    begin
      @task = Task.accessible_by(current_ability).find(params[:id])
      @subtask = Subtask.new({ :task => @task })
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @task }
      end
    rescue
      redirect_to root_path, alert: 'Task was not find.'
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    begin
      @task = Task.accessible_by(current_ability).find(params[:id])
    rescue
      redirect_to root_path, alert: 'Task was not find.'
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = current_user.tasks.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end
end
