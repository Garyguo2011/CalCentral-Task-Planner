require 'spec_helper'
require "pp"

describe Subtask do
  before :all do
    @tasks =[
      {:title => 'Midterm1', :course => 'CS164', :kind => 'Exam', :release => '4/Mar/2015 23:59:00 -0800', :due => '6/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 1, :rate => 3},
      {:title => 'Homework5', :course => 'CS169', :kind => 'Homework', :release => '9/Mar/2015 23:59:00 -0800', :due => '16/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 1, :rate => 3},
      {:title => 'Project2', :course => 'CS164', :kind => 'Project', :release => '9/Mar/2015 23:59:00 -0800', :due => '31/Mar/2015 23:59:00 -0800', :status => 'Started', :user_id => 1, :rate => 3},
      {:title => 'Project3', :course => 'CS164', :kind => 'Project', :release => '9/Mar/2015 23:59:00 -0800', :due => '31/Mar/2015 23:59:00 -0800', :status => 'Finished', :user_id => 1, :rate => 3}
    ]
    @subtasks = [
      {:description => 'subtask1-1project', :is_done => false, :task_id => 1},
      {:description => 'subtask2-1project', :is_done => false, :task_id => 1},
      {:description => 'subtask3-1project', :is_done => true, :task_id => 1},
      {:description => 'subtask4-1project', :is_done => true, :task_id => 1},
      {:description => 'subtask1-2project', :is_done => true, :task_id => 2},
      {:description => 'subtask1-4project', :is_done => true, :task_id => 4},
      {:description => 'subtask1-5project', :is_done => true, :task_id => 4},
      {:description => 'subtask1-6project', :is_done => true, :task_id => 4},
      {:description => 'subtask1-7project', :is_done => false, :task_id => 4}
    ]

    @tasks.each do |task|
      Task.create!(task)
    end
    
    @subtasks.each do |subtask|
      Subtask.create!(subtask)
    end
  end

  describe "complete" do
    it "should return the number of complete subtasks" do
      Task.find(1).subtasks.complete.should eq(2)
      Task.find(2).subtasks.complete.should eq(1)
      Task.find(3).subtasks.complete.should eq(0)
    end
  end

  describe "progress_in_words" do
    it "should return the progress in work eg (4 / 6)" do
      Task.find(1).subtasks.progress_in_words.should eq("2 / 4")
      Task.find(2).subtasks.progress_in_words.should eq("1 / 1")
      Task.find(3).subtasks.progress_in_words.should eq("No Subtasks")
    end
  end

  describe "progress_percent" do
    it "should return the complete percentage of subtasks" do
      Task.find(1).subtasks.progress_percent.should eq("50%")
      Task.find(2).subtasks.progress_percent.should eq("100%")
      Task.find(4).subtasks.progress_percent.should eq("100%")
      expect{Task.find(3).subtasks.progress_percent}.to raise_error(NoMethodError)
    end

    it "should return 0% if task subtask is count 0" do
      Subtask.stub(:count).and_return(0)
      Subtask.progress_percent.should eq("0%")
    end
  end
end