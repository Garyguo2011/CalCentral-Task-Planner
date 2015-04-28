class TasksController < ApplicationController
  #load_and_authorize_resource
  before_filter :check_status
  # GET /tasks
  # GET /tasks.json
  def index_or_dashboard 
    @tasks = Task.accessible_by(current_ability)
    @tasks_by_status = @tasks.task_by_status
    @tasks_by_time = @tasks.order(:due).find_all_by_status(["New", "Started", "Past due"])

    show_finished = (params[:show_finished] == nil)? nil: "Finished"
    @show_finish = (show_finished == nil)? false: true
  end

  def index
    index_or_dashboard
    respond_to do |format|
      format.html 
      format.json { render json: @tasks }
    end
  end

  def sort_argument_helper
    if params[:sort] != nil
      sort_argument = params[:sort]
    else
      sort_argument = :status
    end
    return sort_argument
  end

  def filter_argument_helper
    if params[:filter] != nil and params[:filter] != "Show All"
      filter_argument = params[:filter]
    else
      filter_argument = nil
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
    title = @task.title
    @task.destroy
    if !@task[:auto]
      UserMailer.task_notification(current_user).deliver
    end
    respond_to do |format|
      format.html { redirect_to status_path, notice: "#{title} was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def delete
    destroy
  end

  def check_status
    Task.accessible_by(current_ability).check_past_due
  end 

  def changestatus
    @task = Task.find(params[:id])
    new_status = ""
    case @task.status
    when "New"
      new_status = "Started"
      message = "You have started #{@task.title}"
    when "Started"
      new_status = "Finished"
      message = "You have finished #{@task.title}"
    when "Finished"
      new_status = "Started"
      message = "You have reopen #{@task.title}"
    when "Past due"
      new_status = "Finished"
      message = "You have finished #{@task.title}"
    end

    @task.update_attribute :status, new_status
    if params[:redirect_url] != nil
      redirect_to params[:redirect_url], notice: message
    else
      redirect_to "/tasks", notice: message
    end
  end

  def find_tasks_in_hash
    @tasks = Task.accessible_by(current_ability)
    @all_tasks_array_of_hash = @tasks.all_tasks_in_array_of_hash
  end
  def calendar
    find_tasks_in_hash
    # if(params[:task] != nil)
    #   course, title = params[:task].split(" ")
    #   task_to_change = Task.find_task_by_course_title(course, title)
    #   task_to_change.update_attribute(:due, params[:new_date])
    # end
  end

  def dashboard
    @view = params[:view];
    if (!@view) 
      @view = 'tasklist'
    end
    find_tasks_in_hash

    index_or_dashboard
  end

  def status
    @tasks = Task.accessible_by(current_ability) 
    #filter task by date(this week, this month, this year)
    show_tasks_in_selected_type
    show_tasks_in_selected_date_range
    @taskData = @tasks.work_distribution


  end

  def show_tasks_in_selected_type
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
  end

  def show_tasks_in_selected_date_range
    #filter task by date(this week, this month, this year)
    case params[:date]
    when "this week"
      @tasks = @tasks.find_tasks_in_same_week(Time.now)
    when "this month"
      @tasks = @tasks.find_tasks_in_same_month(Time.now)
    when "this year"
      @tasks = @tasks.find_tasks_in_same_year(Time.now)
    when nil, "all time"
      @tasks
    end

    @taskDataWorkDist = @tasks.work_distribution
    @taskDataPieChart = @tasks.pie_chart_data_generate

    respond_to do |format|       
      format.html { render 'status.html.erb'}
      format.json { render json: @tasks }
    end

  end

  def generate_task
    @auto_tasks = Task.generate_auto(3) # Should be a param later on
    @auto_tasks.each do |t|
      t[:user_id] = current_user.id
      Task.create!(t)
    end
    redirect_to status_path, notice: "We have generate demo data for you! Enjoy!"
  end

  def delete_generate_task
    @tasks = current_user.tasks
    @tasks.where(:auto => true).delete_all
    respond_to do |format|       
      format.html { render 'status.html.erb'}
    end
  end

end


