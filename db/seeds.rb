# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = [
{:email => "xguo@berkeley.edu", :password => "12345678", :first_name => "Xinran", :last_name => "Guo"},
{:email => "zhangjinge588@gmail.com", :password => "12345678", :first_name => "Jinge", :last_name => "Zhang"},
{:email => "garyguo2011@gmail.com", :password => "12345678", :first_name => "Gary", :last_name => "Guo"}
]

tasks =[
{:title => 'Midterm1', :course => 'CS164', :kind => 'Exam', :release => '4/Mar/2015 23:59:00 -0800', :due => '6/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 1},
{:title => 'Homework5', :course => 'CS169', :kind => 'Homework', :release => '9/Mar/2015 23:59:00 -0800', :due => '16/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 1},
{:title => 'Project2', :course => 'CS164', :kind => 'Project', :release => '9/Mar/2015 23:59:00 -0800', :due => '31/Mar/2015 23:59:00 -0800', :status => 'Ongoing', :user_id => 1},
{:title => 'Vatamin#5', :course => 'CS186', :kind => 'Homework', :release => '27/Feb/2015 23:59:00 -0800', :due => '2/Mar/2015 23:59:00 -0800', :status => 'Complete', :user_id => 1},
{:title => 'Jinge_quiz#2', :course => 'CS169', :kind => 'Exam', :release => '12/Mar/2015 23:59:00 -0800', :due => '19/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 2},
{:title => 'Jinge_quiz#3', :course => 'CS169', :kind => 'Exam', :release => '12/Mar/2015 23:59:00 -0800', :due => '19/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 2},
{:title => 'Jinge_quiz#4', :course => 'CS169', :kind => 'Exam', :release => '12/Mar/2015 23:59:00 -0800', :due => '19/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 2},
{:title => 'Jinge_quiz#5', :course => 'CS169', :kind => 'Exam', :release => '12/Mar/2015 23:59:00 -0800', :due => '19/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 2},
{:title => 'Garyguo-midterm1', :course => 'CS164', :kind => 'Exam', :release => '4/Mar/2015 23:59:00 -0800', :due => '6/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 3},
{:title => 'Garyguo-midterm2', :course => 'CS164', :kind => 'Exam', :release => '4/Mar/2015 23:59:00 -0800', :due => '6/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 3},
{:title => 'Garyguo-midterm3', :course => 'CS164', :kind => 'Exam', :release => '4/Mar/2015 23:59:00 -0800', :due => '6/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 3}
]


tasks.each do |task|
	Task.create!(task)
end

users.each do |user|
	User.create!(user)	
end