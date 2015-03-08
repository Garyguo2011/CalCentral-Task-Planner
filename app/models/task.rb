class Task < ActiveRecord::Base
  attr_accessible :due, :status, :title, :course, :kind, :release, :user_id
  belongs_to :user
  has_many :subtasks
end
