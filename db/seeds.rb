# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tasks =[
{:title => 'Midterm1', :course => 'CS164', :kind => 'Exam', :release => '4/Mar/2015 23:59:00 -0800', :due => '4/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 1},
{:title => 'Homework5', :course => 'CS169', :kind => 'Homework', :release => '9/Mar/2015 23:59:00 -0800', :due => '16/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 1},
{:title => 'Project2', :course => 'CS164', :kind => 'Project', :release => '9/Mar/2015 23:59:00 -0800', :due => '31/Mar/2015 23:59:00 -0800', :status => 'Ongoing', :user_id => 1},
{:title => 'Vatamin#5', :course => 'CS186', :kind => 'Homework', :release => '27/Feb/2015 23:59:00 -0800', :due => '2/Mar/2015 23:59:00 -0800', :status => 'Complete', :user_id => 1},
{:title => 'Quiz#2', :course => 'CS169', :kind => 'Exam', :release => '12/Mar/2015 23:59:00 -0800', :due => '19/Mar/2015 23:59:00 -0800', :status => 'New', :user_id => 1}]

tasks.each do |task|
	Task.create!(task)
end
