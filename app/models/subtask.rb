class Subtask < ActiveRecord::Base
  attr_accessible :description, :is_done, :task
  belongs_to :task
end
