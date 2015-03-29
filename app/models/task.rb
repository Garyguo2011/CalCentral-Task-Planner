class MyValidator < ActiveModel::Validator
  def validate(record)
    unless record.due > record.release
      record.errors[:Due] << 'date must be after the Release date!'
    end
  end
end
class Task < ActiveRecord::Base
  attr_accessible :due, :status, :title, :course, :kind, :release, :user_id
  belongs_to :user
  has_many :subtasks
  validates :title, :presence => true
  validates :status, :presence => true
  validates :due, :presence => true
  validates :kind, :presence => true
  validates :course, :presence => true
  validates_with MyValidator

  def all_course
    arr = Array.new
    f = File.open("data.csv", "r")
    f.each_line { |line|
      temp = line.split("\",\"")
      str = "#{temp[2]} #{temp[3]}"
      arr << str
    }
    arr.delete_at(0)
    arr = arr.sort
    a = Array.new
    arr.each do |t|
      temp = t.split("\"")
      a << temp[0]
    end
    return a
  end
  
  def self.all_kinds
    ["Project", "Homework", "Paper", "Exam", "Other"]
  end

  def self.task_by_status
    past_tasks = self.find_all_by_status("Past Due")
    new_tasks = self.find_all_by_status("New")
    ongoing_tasks = self.find_all_by_status("Started")
    ret = []
    ret.push(past_tasks)
    ret.push(ongoing_tasks)
    ret.push(new_tasks)
    return ret
  end
end
