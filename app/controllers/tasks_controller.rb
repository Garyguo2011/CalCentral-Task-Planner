class TasksController < ApplicationController
  #load_and_authorize_resource
  before_filter :check_status
  # GET /tasks
  # GET /tasks.json
  def index_or_dashboard 
    @tasks = Task.accessible_by(current_ability)
    @tasks_by_status = Task.accessible_by(current_ability).task_by_status
    @tasks_by_time = Task.accessible_by(current_ability).order(:due).find_all_by_status(["New", "Started", "Past due"])

    show_finished = (params[:show_finished] == nil)? nil: "Finished"
    @show_finish = (show_finished == nil)? false: true

    respond_to do |format|
      format.html 
      format.json { render json: @tasks }
    end
  end

  def index
    index_or_dashboard
  end

  def sort_argument_helper
    if params[:sort] != nil
      sort_argument = params[:sort]
      session[:sort] = sort_argument
    elsif session[:sort] != nil
      sort_argument = session[:sort]
    else
      sort_argument = :status
      session[:sort] = sort_argument
    end
    return sort_argument
  end

  def filter_argument_helper
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
    return filter_argument
  end


  def prefill_subtasks_helper
    if params[:needPrefill] == 'yes'
      @type = @task.kind
      if @type == 'Homework'
        @numProb = params[:numProb]
      end
      old_subtasks = @task.subtasks.find_all_by_task_id(@task.id)
      old_subtasks.each do |os|
        os.destroy
      end
      subtasks = Subtask.prefill(@type, @numProb)
      subtasks.each do |subtask|
        @task.subtasks.create!({:description => subtask, :is_done => false, :task_id => @task.id})
      end
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
        prefill_subtasks_helper
        UserMailer.task_create_confirmation(current_user).deliver
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
        prefill_subtasks_helper
        UserMailer.task_update_confirmation(current_user).deliver
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

  def check_status
    Task.accessible_by(current_ability).check_past_due
  end 

  def changestatus
    @task = Task.find(params[:id])
    new_status = ""
    case @task.status
    when "New"
      @start_at = Time.now
      new_status = "Started"
    when "Started"
      @finish_at = Time.now
      new_status = "Finished"
    when "Finished"
      @start_at = Time.now
      @finish_at = nil
      new_status = "Started"
    when "Past due"
      @finish_at = Time.now
      new_status = "Finished"
    end

    @task.update_attribute :status, new_status
    redirect_to "/tasks"
  end

  def calendar
    @tasks = Task.accessible_by(current_ability)
    @all_tasks_array_of_hash = @tasks.all_tasks_in_array_of_hash
    # if(params[:task] != nil)
    #   course, title = params[:task].split(" ")
    #   task_to_change = Task.find_task_by_course_title(course, title)
    #   task_to_change.update_attribute(:due, params[:new_date])
    # end
  end

  def dashboard
    @view = params[:view];
    if (!@view) 
      @view = 'tasklist';
    end
    index_or_dashboard
  end

  def status
    @tasks = Task.accessible_by(current_ability)

    sort_argument = sort_argument_helper   
    filter_argument = filter_argument_helper

    show_finished = (params[:show_finished] == nil)? nil: "Finished"
    @show_finish = false

    if filter_argument == nil and show_finished == nil
      @tasks = Task.where("status != ? AND user_id = ?", "Finished", current_user).order(sort_argument)
    elsif filter_argument != nil and show_finished != nil
      @tasks = @tasks.order(sort_argument).where("kind = ?", filter_argument)
      @show_finish = true
    elsif filter_argument != nil
      @tasks = Task.where("status != ? AND user_id = ?", "Finished", current_user).order(sort_argument).where("kind = ?", filter_argument)
    else
      @tasks = @tasks.order(sort_argument)
      @show_finish = true
    end

    @taskData = @tasks.work_distribution

  end

end


