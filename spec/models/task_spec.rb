require 'spec_helper'
require 'pp'

describe Task do
  before :all do
    @tasks =[
      {:title => 'Midterm1', :course => 'CS164', :kind => 'Exam', :release => '4/Mar/2015 23:59:00 -0800', :due => '6/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 1, :rate => 3},
      {:title => 'Homework5', :course => 'CS169', :kind => 'Homework', :release => '9/Mar/2015 23:59:00 -0800', :due => '16/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 1, :rate => 3},
      {:title => 'Project2', :course => 'CS164', :kind => 'Project', :release => '9/Mar/2015 23:59:00 -0800', :due => '31/Mar/2015 23:59:00 -0800', :status => 'Started', :user_id => 1, :rate => 3},
      {:title => 'Project3', :course => 'CS164', :kind => 'Project', :release => '9/Mar/2015 23:59:00 -0800', :due => '31/Mar/2015 23:59:00 -0800', :status => 'Finished', :user_id => 1, :rate => 3}
    ]
    @tasks.each do |task|
      Task.create!(task)
    end
  end
  before(:each) do
    @task = FactoryGirl.create(:task)
  end

  describe "all kinds" do
    it "should have all kinds" do
      Task.all_kinds.should eq(["Project", "Homework", "Paper", "Exam", "Other"])
    end
  end

  describe "all_course" do
    it "should browse all courses" do
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
        a << "General"
        arr.each do |t|
            temp = t.split("\"")
            a << temp[0]
        end
        a.should eq(Task.all_course)
    end
  end

  describe "Remaining Time" do
    it "should include the time length between due date and time now" do
      Time.stub(:now).and_return("5/Mar/2015 22:00:00 -0800".to_datetime)
      @task.due = "8/Mar/2015 22:00:00 -0800"
      @task.status = "New"
      @task.remain_time.should eq("3 days left")
    end

    it "should be contain passed if time pass due date" do
      Time.stub(:now).and_return("5/Mar/2015 22:00:00 -0800".to_datetime)
      @task.due = "5/Mar/2015 18:00:00 -0800"
      @task.status = "New"
      @task.remain_time.should eq("about 4 hours passed")
    end

    it "should display as finished if a task is finished" do
      Time.stub(:now).and_return("5/Mar/2015 22:00:00 -0800".to_datetime)
      @task.due = "5/Mar/2015 18:00:00 -0800"
      @task.status = "Finished"
      @task.remain_time.should eq("Finished")
    end
  end

  describe "time usage percentage" do
    it "should show the time used percentage" do
      Time.stub(:now).and_return("3/Mar/2015 22:00:00 -0800".to_time)
      @task.release = "1/Mar/2015 22:00:00 -0800".to_time
      @task.due = "5/Mar/2015 22:00:00 -0800".to_time
      @task.status = "New"
      # pp @task.remain_time
      # pp @task.time_usage_in_day
      @task.time_usage_percent.should eq("50%")
    end

    it "should return 100% once the task finished" do
      Time.stub(:now).and_return("3/Mar/2015 22:00:00 -0800".to_time)
      @task.release = "1/Mar/2015 22:00:00 -0800".to_time
      @task.due = "5/Mar/2015 22:00:00 -0800".to_time
      @task.status = "Finished"
      @task.time_usage_percent.should eq("100%")
    end
  end

  describe "time usage in day" do
    it "should show the time used in days" do
      Time.stub(:now).and_return("3/Mar/2015 22:00:00 -0800".to_time)
      @task.release = "1/Mar/2015 22:00:00 -0800".to_time
      @task.due = "5/Mar/2015 22:00:00 -0800".to_time
      @task.status = "New"
      # pp @task.remain_time
      # pp @task.time_usage_in_day
      @task.time_usage_in_day.should eq("2.0 / 4.0")
    end

    it "should return finished when task finished" do
      Time.stub(:now).and_return("3/Mar/2015 22:00:00 -0800".to_time)
      @task.release = "1/Mar/2015 22:00:00 -0800".to_time
      @task.due = "5/Mar/2015 22:00:00 -0800".to_time
      @task.status = "Finished"
      @task.time_usage_in_day.should eq("Finished")
    end

    it "should return day_used == 0 when time usgage is 0" do
      Time.stub(:now).and_return("3/Apr/2015 22:00:00 -0800".to_time)
      @task.release = "6/Apr/2015 22:00:00 -0800".to_time
      @task.due = "9/Apr/2015 22:00:00 -0800".to_time
      @task.time_usage_in_day.should eq("0.0 / 3.0")
    end

    it "should return day_used == total day when time usgage is 1" do
      Time.stub(:now).and_return("10/Apr/2015 22:00:00 -0800".to_time)
      @task.release = "6/Apr/2015 22:00:00 -0800".to_time
      @task.due = "9/Apr/2015 22:00:00 -0800".to_time
      @task.time_usage_in_day.should eq("3.0 / 3.0")
    end    

  end

  describe "time usage" do
    it "should reutrn 0 when release > time now" do
      Time.stub(:now).and_return("3/Apr/2015 22:00:00 -0800".to_time)
      @task.release = "6/Apr/2015 22:00:00 -0800".to_time
      @task.time_usage.should eq(0)
    end
  end

  describe "Work load Distribution" do
    before(:each) do
      Time.stub(:now).and_return("15/Mar/2015 22:00:00 -0800".to_date)
      @startDate = "30/Mar/2015".to_date
      @endDate = "20/Apr/2015".to_date
    end

    describe "work_distribution label (wd_labels)" do
      it "should return the time frame in term of week" do
        startDate = "30/Mar/2015".to_date
        n = 4
        # expect(Task.wd_labels(startDate, n)).to be(["Mar30 - Apr06", "Apr06 - Apr13", "Apr13 - Apr20", "Apr20 - Apr27"])/
        Task.wd_labels(startDate, n).should ==(["Mar30", "Apr06", "Apr13", "Apr20"])
      end
    end

    describe "return the whole data set of graph" do
      it "should generate datasets for work distriution" do
        expect(Task.wd_tasks(@startDate, @endDate)[0]["label"]).to eq("Project2")
        expect(Task.wd_tasks(@startDate, @endDate)[1]["label"]).to eq("Project3")
      end
    end

    describe "work_distribution in range" do
      it "release is before @endDate and due is after @startDate, expected true" do
        @task.release = "30/Jan/2015".to_date
        @task.due = "30/May/2015".to_date
        @task.wd_in_range(@startDate, @endDate).should be_true
      end
      it "release is after @endDate and due is after @startDate, expected false" do
        @task.release = "30/Apr/2015".to_date
        @task.due = "30/Jan/2015".to_date
        @task.wd_in_range(@startDate, @endDate).should be_false
      end
      it "release is before @endDate and due is before @startDate, expected false" do
        @task.release = "11/Apr/2015".to_date
        @task.due = "30/Jan/2015".to_date
        @task.wd_in_range(@startDate, @endDate).should be_false
      end
      it "release is after @endDate and due is after @startDate, expected false" do
        @task.release = "30/Apr/2015".to_date
        @task.due = "30/Jan/2015".to_date
        @task.wd_in_range(@startDate, @endDate).should be_false
      end
    end

    describe "hash to hex string" do
      it "shoule change the hash code of oject to 24 bit hex code" do
        @task.stub(:hash).and_return(123456789101112131415)
        @task.hash_to_hex_s.should eq("1aff57")
      end
    end
    describe "return task_array given startDate and endDate" do
      it "generate task array with its rate for every week" do
        @task.rate = 3
        @task.release = "05/Apr/2015".to_date
        @task.due = "05/May/2015".to_date
        @task.task_array(@startDate, @endDate).should == [3, 3, 3, 3]
      end
      it "generate task array with its rate only for first week" do
        @task.rate = 3
        @task.release = "05/Jan/2015".to_date
        @task.due = "05/Apr/2015".to_date
        @task.task_array(@startDate, @endDate).should == [3, 0, 0, 0]
      end
      it "generate task array accordingly" do
        @task.rate = 3
        @task.release = "07/Apr/2015".to_date
        @task.due = "05/May/2015".to_date
        @task.task_array(@startDate, @endDate).should == [0, 3, 3, 3]
      end
    end
  end

  describe "rate valid" do
    it "should pass if rate is in 1-5" do
      @task.rate = 5
      expect(@task.save).to be_true
    end

    it "should not pass if rate not in 1-5" do
      @task.rate = 8
      expect(@task.save).to be_false
      @task.rate = -1
      expect(@task.save).to be_false
      @task.rate = 0
      expect(@task.save).to be_false
    end
  end

  describe "task alert message" do
    before :each do
      @task.release = "1/Apr/2015 22:00:00 -0800".to_time
      @task.due = "10/Apr/2015 22:00:00 -0800".to_time
      @task.status = "Started"
    end

    it "should show nice when task finish" do
      @task.status = "Finished"
      Time.stub(:now).and_return("9/Apr/2015 22:00:00 -0800".to_time)
      @task.alert[:message].should eq("Nice work, you have completed task.")
      @task.alert[:type].should eq("alert-success")
    end

    it "should alert when task has pass due" do
      Time.stub(:now).and_return("11/Apr/2015 22:00:00 -0800".to_time)
      @task.alert[:message].should eq("Code Red! Midterm1 have passed Due. Please finish ASAP!!!")
      @task.alert[:type].should eq("alert-danger")
    end

    it "should alert hurry up when task 90% usage" do
      Time.stub(:now).and_return("10/Apr/2015 09:00:00 -0800".to_time)
      @task.alert[:message].should eq("Hurry up! Midterm1 have used 94% of Time, is due about 13 hours")
      @task.alert[:type].should eq("alert-danger")
    end

    it "should aler hurry up and remain_time when 70% usage" do
      Time.stub(:now).and_return("8/Apr/2015 22:00:00 -0800".to_time)
      @task.alert[:message].should eq("Hurry up! Midterm1 is due 2 days")
      @task.alert[:type].should eq("alert-danger")
    end
    
    it "should alert when usage > 0.5 but still new" do
      @task.status = "New"
      Time.stub(:now).and_return("6/Apr/2015 22:00:00 -0800".to_time)
      @task.alert[:message].should eq("Head up! You have pass half of time, but you haven't started!")
      @task.alert[:type].should eq("alert-warning")
    end

    it "should alert when usage > 0.5 but already started" do
      Time.stub(:now).and_return("6/Apr/2015 22:00:00 -0800".to_time)
      @task.alert[:message].should eq("Hurry up! Midterm1 is due 4 days")
      @task.alert[:type].should eq("alert-warning")
    end

    it "should alert when usage < 0.5 when new task have release" do
      @task.status = "New"
      Time.stub(:now).and_return("3/Apr/2015 22:00:00 -0800".to_time)
      @task.alert[:message].should eq("New Task have been release. Please consider to start to work on it")
      @task.alert[:type].should eq("alert-info")
    end

    it "should alert Keept it up, when usage < 0.5, user have start task" do
      Time.stub(:now).and_return("3/Apr/2015 22:00:00 -0800".to_time)
      @task.alert[:message].should eq("Keep it up! You are early bird!")
      @task.alert[:type].should eq("alert-info")
    end
  end

  describe "label" do
    it "should proper color label" do
      @task.status = "New"
      @task.label.should eq("label-default")
    end
  end

  describe "all_tasks_in_array_of_hash" do
    it "should return all task as array or hash" do
      Task.all_tasks_in_array_of_hash
    end
  end

  describe "auto generate tasks" do
    it "should auto generate tasks for the next 4-month time span" do
      @tasks = Task.generate_auto(3)
      @tasks.each do |task|
        task[:auto].should eq(true)
      end
    end
  end

  describe "task chagne status button" do
    it "should return the proper color button to task" do
      @task.status == "New"
      @task.change_status_button.should eq('<i class="fa fa-play"></i> Start')
    end
  end

  describe "task data range" do
    it "should return this week this month ..." do
      Task.date_range.should eq(["this week", "this month", "this year", "all time"])
    end
  end

  describe "find_tasks_in_same_week" do
    it "find_tasks_in_same_week" do
      Time.stub(:now).and_return("3/Mar/2015 22:00:00 -0800".to_time)
      Task.find_tasks_in_same_week(Time.now)
    end
  end

  describe "find_tasks_in_same_month" do
    it "find_tasks_in_same_month" do
      Time.stub(:now).and_return("3/Mar/2015 22:00:00 -0800".to_time)
      Task.find_tasks_in_same_month(Time.now)
    end
  end

   describe "find_tasks_in_same_year" do
    it "find_tasks_in_same_year" do
      Time.stub(:now).and_return("3/Mar/2015 22:00:00 -0800".to_time)
      Task.find_tasks_in_same_year(Time.now)
    end
  end

  describe "generate_auto" do
    it "generate_auto" do
      Task.stub(:is_tech).and_return(true)
      Task.generate_auto(3)
    end
  end

end
