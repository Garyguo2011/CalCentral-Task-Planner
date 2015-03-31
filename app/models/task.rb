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

  def remain_time
    remain_time = distance_of_time_in_words(self.due, Time.now, include_seconds: true)
    if self.due > Time.now
      return remain_time + " left"
    else
      return remain_time + " passed"
    end
  end

  def time_usage_percent
    percent = (Time.now - self.release) / (self.due - self.release) * 100
    return  "%.0f%" % (percent)
    # if self.due > Time.now
    #   percent = (Time.now - self.release) / (self.due - self.release) * 100
    #   return percent.to_s + "%"
    # else
    #   percent = (Time.now - self.release) / (self.due - self.release) * 100
    #   return percent.to_s + "%"
    # end
  end

  def time_usage_in_day
    day_used = (Time.now - self.release) / 1.day
    total_day = (self.due - self.release) / 1.day
    return "%.1f days / %.1f days" % [day_used, total_day]
    # return ((Time.now - self.release) / 1.day).to_s + " days / " + ((self.due - self.release) / 1.day).to_s
  end

end
