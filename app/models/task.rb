class Task < ActiveRecord::Base
  attr_accessible :due, :status, :title
end
