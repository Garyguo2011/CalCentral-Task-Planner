class Subtask < ActiveRecord::Base
  attr_accessible :description, :is_done, :task, :task_id
  belongs_to :task
  validates :description, :presence => true
  validates :task, :presence => true

  def self.complete () 
    return self.where("is_done == ?", true).count
  end

  def self.progress_in_words () 
    if (self.count > 0)
      return self.complete.to_s + " / " + self.count.to_s
    end
    return "No Subtasks"
  end

  def self.progress_percent () 
    if (self.count > 0 && self.first.task.status != "Finished") 
      percent = ((self.complete * 100) / self.count)
      return  "%.0f%" % (percent)
    elsif (self.first.task.status == "Finished")
      return "100%"
    else
      return "0%"
    end
  end
end