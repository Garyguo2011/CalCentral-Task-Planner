class Task < ActiveRecord::Base
  attr_accessible :due, :status, :title, :course, :kind, :release
  has_many :subtasks
end
