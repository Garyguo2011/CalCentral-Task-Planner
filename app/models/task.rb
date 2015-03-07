class Task < ActiveRecord::Base
  attr_accessible :due, :status, :title, :course, :kind, :release
end
