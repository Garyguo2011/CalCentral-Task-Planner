require 'spec_helper'

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

end
