class MyValidator < ActiveModel::Validator
  def validate(record)
    unless record.due != nil && record.release != nil && record.due > record.release
      record.errors[:Due] << 'date must be after the Release date!'
    end
    unless record.rate != nil && record.rate >= 1 && record.rate <= 5
      record.errors[:rate] << 'Rate must between 1 to 5'
    end
  end
end

class Task < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  attr_accessible :due, :status, :title, :course, :kind, :release, :user_id, :rate, :auto
  belongs_to :user
  has_many :subtasks
  validates :title, :presence => true
  validates :status, :presence => true
  validates :due, :presence => true
  validates :kind, :presence => true
  validates :course, :presence => true
  validates :rate, :presence => true
  validates_with MyValidator

  def self.all_course
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

  def self.all_status
    ["Past due", "New", "Started", "Finished"]
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

  def self.pie_chart_data_generate
    result = Array.new
    for i in 0..3
      result << self.hash_for_pie_chart(self.all_status[i])
    end
    return result
  end

  def self.hash_for_pie_chart(status)
    result = Hash.new
    result["label"] = status
    result["data"] = self.find_all_by_status(status).size
    return result
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

  def remain_time_words
    return distance_of_time_in_words(self.due, Time.now, include_seconds: true)
  end

  def remain_time
    if self.status != "Finished"
      remain_time = self.remain_time_words
      if self.due > Time.now
        return remain_time + " left"
      else
        return remain_time + " passed"
      end
    else
      return "Finished"
    end
  end

  def time_usage
    if self.release > Time.now
      return 0
    end
    time_usage_float = (Time.now - self.release) / (self.due - self.release)
    if time_usage_float > 1 || self.status == "Finished"
      return 1
    end
    return time_usage_float
  end

  def time_usage_percent
    return "%.0f%" % (self.time_usage * 100)
  end

  def time_usage_in_day
    if self.status == "Finished"
      return "Finished"
    end
    total_day = (self.due - self.release) / 1.day
    case self.time_usage
    when 0
      day_used = 0
    when 1
      day_used = total_day
    else
      day_used = (Time.now - self.release) / 1.day
    end
    return "%.1f / %.1f" % [day_used, total_day]
  end

  def self.work_distribution
    n = 8 # to be modified
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
      labels << startDate.strftime("%b%d").to_s
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
      hash_task["fillColor"] = "#2b6181"
      hash_task["highlightFill"] = "#2b6181"
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

  def label
    labels = { "New" => "label-default", "Started" => "label-warning", "Past due"=> "label-important", "Finished" => "label-success" }
    return labels[self.status]
  end

  def change_status_button
    button = {"Past due" => '<i class="fa fa-check"></i> Finish', "New" => '<i class="fa fa-play"></i> Start', "Started" => '<i class="fa fa-check"></i> Finish', "Finished" => '<i class="fa fa-repeat"></i> Reopen'}
    return button[self.status]
  end

  #all tasks in array of hash format
  def self.all_tasks_in_array_of_hash
    tasks_array = []
    self.all.each do |task|
      title = task.course + " " + task.title
      end_time = task.due
      tasks_array.push({'title' => title, 'start' => end_time})
    end
    return tasks_array
  end

  #find task by course + title
  # def self.find_task_by_course_title(target_course, target_title)
  #   tasks = self.where(course: target_course).find_by_title(target_title)
  #   return tasks
  # end

  def alert
    if self.status == "Finished"
      return {
        :type => "alert-success",
        :message => "Nice work, you have completed task."
      }
    end
    
    usage = self.time_usage 
    if usage == 1
      return {
        :type => "alert-danger",
        :message => "Code Red! #{self.title} have passed Due. Please finish ASAP!!!"
      }
    end

    if usage >= 0.9
      return {
        :type => "alert-danger",
        :message => "Hurry up! #{self.title} have used #{self.time_usage_percent} of Time, is due #{self.remain_time_words}"
      }
    end
    
    if usage >= 0.7
      return {
        :type => "alert-danger",
        :message => "Hurry up! #{self.title} is due #{self.remain_time_words}"
      }
    end
    
    if usage >= 0.5
      if self.status == "New"
        return {
          :type => "alert-warning",
          :message => "Head up! You have pass half of time, but you haven't started!"
        }
      else
        return {
          :type => "alert-warning",
          :message => "Hurry up! #{self.title} is due #{self.remain_time_words}"
        }
      end
    end

    if self.status == "New"
      return {
        :type => "alert-info",
        :message => "New Task have been release. Please consider to start to work on it"
      }
    else
      return {
        :type => "alert-info",
        :message => "Keep it up! You are early bird!"
      }
    end
  end

  def self.generate_message
    @temp_tasks = self.all(:conditions => ["status != (?) AND status != (?) AND due <= (?)", "Past due", "Finished", Time.now+7.days])
    @message = "Summary of your tasks: \n"
    i = 1
    @temp_tasks.each do |t|
      @message << "Task No.#{i}\n"
      @message << t.generate_message_for_each_task
      i += 1
    end
    return @message
  end

  def generate_message_for_each_task
    @m = "Task Title: #{self.title}\n"
    @m << "Course: #{self.course}\n"
    @m << "Kind: #{self.kind}\n"
    @m << "Due Time: #{self.due}\n"
    @m << "Remainning time: #{self.remain_time}\n\n"
  end

  def self.days_between_release_and_due(kind)
    case kind
    when 'Project', 'Paper'
      return 2.weeks
    when 'Homework'
      return 7.days
    when 'Exam'
      return 3.hours
    end
  end

  def self.is_tech(course)
    return course.include?("Computer") || course.include?("Engineering")
  end

  def self.is_humanities(course)
    return !self.is_tech(course) && !course.include?("Mathematics") && !course.include?("Statistics") && !course.include?("Physics") && !course.include?("Chemistry")
  end

  def self.generate_auto(num_of_courses)
    @all_tasks = Array.new
    @random = Random.new
    @courses = self.all_course
    for i in 1..num_of_courses
      course = @courses[@random.rand(0..@courses.size-1)]
      @all_tasks.concat(self.generate_tasks('Homework', @random.rand(3..6), course))
      @all_tasks.concat(self.generate_tasks('Exam', @random.rand(1..3), course))
      if self.is_tech(course)
        @all_tasks.concat(self.generate_tasks('Project', @random.rand(1..4), course))
      end
      if self.is_humanities(course)
        @all_tasks.concat(self.generate_tasks('Paper', @random.rand(1..3), course))
      end
    end
    return @all_tasks
  end

  def self.generate_tasks(kind, n, course)
    @days_between_tasks = (120/(n+1)).floor
    release_dateTime = DateTime.now + Random.new.rand(7..13).days # Don't know where to start our tasks plan
    if kind == 'Exam'
      release_dateTime += 3.weeks
    end
    @tasks = Array.new
    for i in 1..n
      task = self.generate_task(kind, release_dateTime, i, course)
      @tasks << task
      release_dateTime += @days_between_tasks
    end
    return @tasks
  end

  def self.generate_task(kind, release_dateTime, i, course)
    @task = Hash.new
    @task[:status] = 'New'
    @task[:release] = release_dateTime
    @task[:due] = release_dateTime + self.days_between_release_and_due(kind)
    @task[:rate] = Random.new.rand(1..5)
    @task[:title] = kind + "#{i}"
    @task[:course] = course
    @task[:kind] = kind + ""
    @task[:auto] = true
    return @task
  end

end
