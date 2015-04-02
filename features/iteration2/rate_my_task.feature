Feature: Rate My Task

  As a student at UC Berkeley
  In order to reserve proper time to finish a task
  I want to rate my task difficulty from 1 to 5

Background: users and tasks have been added to database
  
  Given the following users exist:
  | first_name | last_name | email                   | password  | 
  | Xinran     | Guo       | xinran@gmail.com        | 111111111 |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | rate  | user_id |
  | TST       | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 6/Mar/2015 23:59:00 -0800  | New      | 1     | 1       |
  
  And I am on the sign-in page
  Given I sign in "xinran@gmail.com" with "111111111"
  Then I should be on the homepage

Scenario: add task with rate 1-5 (happy path)
  When I follow "Add new task"
  When I select "5" from "Rate"
  When I fill in "Title" with "CS169 HW"
  When I fill in "task_release" with "2015-03-29 10:40: -07:00"
  When I fill in "task_due" with "2015-03-29 20:25: -07:00"
  When I select "New" from "Status"
  When I select "Homework" from "Kind"
  When I select "Computer Science 169" from "Course"
  And I press "Create Task"
  Then I should see "Task was successfully created."
  Then I should see "3" with the scope of "task_rate"

Scenario: Update task rate
  When I follow "TST"
  When I press "Edit Task"
  Then I would see "1" in my "Rate"
  Then I should see "3" with the scope of "task_rate"
  When I select "3" from "Rate"
  And I select "New" from "Status"
  Then I press "Update Task"
  Then I should see "Task was successfully updated."
  Then I should see "3" with the scope of "task_rate"

Scenario: Input rate not in 1-5 will cause error (test in rspec)