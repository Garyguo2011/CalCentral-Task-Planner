class SubtasksController < ApplicationController
  # GET /subtasks
  # GET /subtasks.json
  before_filter :load_task

  def index
    @subtasks = @task.subtasks

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subtasks }
    end
  end

  # GET /subtasks/1
  # GET /subtasks/1.json
  def show
    @subtask = @task.subtasks.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subtask }
    end
  end

  # GET /subtasks/new
  # GET /subtasks/new.json
  def new
    @subtask = @task.subtasks.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subtask }
    end
  end

  # GET /subtasks/1/edit
  def edit
    @subtask = @task.subtasks.find(params[:id])
  end

  # POST /subtasks
  # POST /subtasks.json
  def create
    @subtask = @task.subtasks.create(params[:subtask])
    respond_to do |format|
      if @subtask.save
        format.html { redirect_to [@subtask.task], notice: 'Subtask was successfully created.' }
        format.json { render json: @subtask, status: :created, location: @subtask }
      else
        format.html { render action: "new" }
        format.json { render json: @subtask.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subtasks/1
  # PUT /subtasks/1.json
  def update
    @subtask = @task.subtasks.find(params[:id])
    respond_to do |format|
      if @subtask.update_attributes(params[:subtask])
        format.html { redirect_to [@subtask.task], notice: 'Subtask was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subtask.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subtasks/1
  # DELETE /subtasks/1.json
  def destroy
    @subtask = @task.subtasks.find(params[:id])
    @subtask.destroy

    respond_to do |format|
      format.html { redirect_to [@task], notice: 'Subtask was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def load_task
    @task = Task.accessible_by(current_ability).find(params[:task_id])
  end
end
