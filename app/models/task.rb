class MyValidator < ActiveModel::Validator
  def validate(record)
    unless record.due > record.release
      record.errors[:Due] << 'date must be after the Release date!'
    end
    unless record.rate >= 1 && record.rate <= 5
      record.errors[:rate] << 'Rate must between 1 to 5'
    end
  end
end

class Task < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  attr_accessible :due, :status, :title, :course, :kind, :release, :user_id, :rate
  belongs_to :user
  has_many :subtasks
  validates :title, :presence => true
  validates :status, :presence => true
  validates :due, :presence => true
  validates :kind, :presence => true
  validates :course, :presence => true
  validates :rate, :presence => true
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
    past_tasks = self.find_all_by_status("Past due")
    new_tasks = self.find_all_by_status("New")
    ongoing_tasks = self.find_all_by_status("Started")
    finished_tasks = self.find_all_by_status("Finished")
    ret = []
    ret.push(past_tasks)
    ret.push(ongoing_tasks)
    ret.push(new_tasks)
    ret.push(finished_tasks)
    return ret
  end

  def self.check_past_due
    current_tasks = self.find_all_by_status(["New", "Started"])
    current_tasks.each do |task|
      if Time.now > task.due
        task.status = "Past due"
        task.save!
      end
    end
  end

  def remain_time
    if self.status != "Finished"
      remain_time = distance_of_time_in_words(self.due, Time.now, include_seconds: true)
      if self.due > Time.now
        return remain_time + " left"
      else
        return remain_time + " passed"
      end
    else
      return "Finished"
    end
  end

  def time_usage_percent
    if self.status != "Finished"
      percent = (Time.now - self.release) / (self.due - self.release) * 100
      return  "%.0f%" % (percent)
    else
      return "100%"
    end
  end

  def time_usage_in_day
    if self.status == "Finished"
      return "Finished"
    end
    day_used = (Time.now - self.release) / 1.day
    total_day = (self.due - self.release) / 1.day
    return "%.1f / %.1f" % [day_used, total_day]
  end

  def self.work_distribution
    n = 4 # to be modified
    startDate = Date.today.at_beginning_of_week
    endDate = startDate + (n * 7).days
    hash = Hash.new
    hash["labels"] = self.wd_labels(startDate, n)
    hash["datasets"] = self.wd_tasks(startDate, endDate)
    return hash
  end

  def self.wd_labels(startDate, n)
    labels = Array.new
    for i in 1..n
      labels << startDate.strftime("%b%d").to_s + " - " + (startDate + 7.days).strftime("%b%d").to_s
      startDate += 7.days
    end
    return labels
  end

  def self.wd_tasks(startDate, endDate)
    all_tasks = self.all(:conditions => ["release <= (?) AND due >= (?)", endDate, startDate])
    arr = Array.new
    all_tasks.each do |task|
      hash_task = Hash.new
      hash_task["label"] = "#{task.title}"
      hash_task["fillColor"] = "#" + task.hash_to_hex_s
      hash_task["highlightFill"] = "#" + task.hash_to_hex_s
      task_arr = task.task_array(startDate, endDate)
      hash_task["data"] = task_arr
      arr << hash_task
    end
    return arr
  end

  def task_array(startDate, endDate)
    task_arr = Array.new
    d = startDate
    while d <= endDate
      if self.wd_in_range(d, d+7.days)
        task_arr << self.rate
      else
        task_arr << 0
      end
      d += 7.days
    end
    return task_arr
  end
  
  def hash_to_hex_s
    return (self.hash % (2 ** 24)).to_s(16)
  end

  def wd_in_range(startDate, endDate)
    return self.release <= endDate && self.due >= startDate
  end

end
