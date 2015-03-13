class Subtask < ActiveRecord::Base
  attr_accessible :description, :is_done, :task, :task_id
  belongs_to :task
end
