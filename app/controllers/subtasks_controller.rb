class SubtasksController < ApplicationController
  # GET /subtasks
  # GET /subtasks.json
  def index
    task = Task.find(params[:task_id])
    @subtasks = task.subtasks

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subtasks }
    end
  end

  # GET /subtasks/1
  # GET /subtasks/1.json
  def show
    task = Task.find(params[:task_id])
    @subtask = task.subtasks.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subtask }
    end
  end

  # GET /subtasks/new
  # GET /subtasks/new.json
  def new
    task = Task.find(params[:task_id])
    @subtask = task.subtasks.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subtask }
    end
  end

  # GET /subtasks/1/edit
  def edit
    task = Task.find(params[:task_id])
    @subtask = task.subtasks.find(params[:id])
  end

  # POST /subtasks
  # POST /subtasks.json
  def create
    task = Task.find(params[:task_id])
    @subtask = task.subtasks.create(params[:subtask])

    respond_to do |format|
      if @subtask.save
        format.html { redirect_to [@subtask.task, @subtask], notice: 'Subtask was successfully created.' }
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
    task = Task.find(params[:task_id])
    @subtask = task.subtasks.find(params[:id])

    respond_to do |format|
      if @subtask.update_attributes(params[:subtask])
        format.html { redirect_to [@subtask.task, @subtask], notice: 'Subtask was successfully updated.' }
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
    task = Task.find(params[:task_id])
    @subtask = task.subtasks.find(params[:id])
    @subtask.destroy

    respond_to do |format|
      format.html { redirect_to task_path(task) }
      format.json { head :no_content }
    end
  end
end
