require 'spec_helper'
require 'pp'

describe Task do
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
    		arr.each do |t|
      			temp = t.split("\"")
      			a << temp[0]
    		end
    		a.should eq(@task.all_course)
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
      @task.time_usage_in_day.should eq("2.0 days / 4.0 days")
    end

    it "should return finished when task finished" do
      Time.stub(:now).and_return("3/Mar/2015 22:00:00 -0800".to_time)
      @task.release = "1/Mar/2015 22:00:00 -0800".to_time
      @task.due = "5/Mar/2015 22:00:00 -0800".to_time
      @task.status = "Finished"
      @task.time_usage_in_day.should eq("Finished")
    end
  end

  describe "Work load Distribution" do
    describe "chart lable and data set (work_distribution)" do
    end

    describe "work_distribution label (wd_labels)" do
      it "should return the time frame in term of week" do
        startDate = "30/Mar/2015".to_date
        n = 4
        # expect(Task.wd_labels(startDate, n)).to be(["Mar30 - Apr06", "Apr06 - Apr13", "Apr13 - Apr20", "Apr20 - Apr27"])/
        Task.wd_labels(startDate, n).should ==(["Mar30 - Apr06", "Apr06 - Apr13", "Apr13 - Apr20", "Apr20 - Apr27"])
      end
    end

    describe "return the whole data set of graph" do

    end

    describe "work_distribution in range" do
      before(:each) do
        @startDate = "30/Mar/2015".to_date
        @endDate = "20/Apr/2015".to_date
      end
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
  end
end
