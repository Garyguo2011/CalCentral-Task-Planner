class Subtask < ActiveRecord::Base
  attr_accessible :description, :is_done, :task, :task_id
  belongs_to :task
  validates :description, :presence => true
  validates :task, :presence => true
end
