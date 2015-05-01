Feature: Distribution Bar Chart Improvement [Jinge]
As staff of CalCentral
In order to make workload distribution more friendly to user.
We want to construct a new page with workload distribution chart

Background: users and tasks have been added to database
  
  Given it is currently Apr,1 2015
  
  Given the following users exist:
  | first_name | last_name | email                   | password  | 
  | Jinge      | Zhang     | zhangjinge588@gmail.com | 12345678  |
  | Rod        | Zhang     | zhangjinge0110@126.com  | 12345678  |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | rate | user_id |
  | HW1       | CS169  | Homework | 4/Jan/2015 23:59:00 -0800  | 6/Jan/2015 23:59:00 -0800  | New      |   1  | 1       |
  | PROJ1     | CS169  | Project  | 9/Apr/2015 23:59:00 -0800  | 16/Apr/2015 23:59:00 -0800 | New      |   2  | 1       |
  | ESSAY1    | CS195  | Paper    | 9/Apr/2015 23:59:00 -0800  | 31/Apr/2015 23:59:00 -0800 | Started  |   3  | 1       |
  | HW2       | CS186  | Homework | 27/Feb/2015 23:59:00 -0800 | 2/Apr/2015 23:59:00 -0800  | Started  |   4  | 2       |
  | MIDTERM1  | CS164  | Exam     | 1/Apr/2015 12:00:00 -8000  | 4/Apr/2015 16:00:00 -0800  | Finished |   5  | 2       |
  Given I am on the sign-in page
  And I sign in "zhangjinge588@gmail.com" with "12345678"
  Then I am on the home page

  Scenario: Go to the page for workload distribution chart
  	Given I am on the home page
    When I follow "My Status"
  	Then I should be on the status page
    Then I should see "PROJ1" with the scope of "work_distribution_chart"
    Then I should not see "HW1" with the scope of "work_distribution_chart"

  Scenario: Update a task would update the workload distribution chart
  	Given I am on the home page
  	When I follow "Add new task"
  	Then I should currently on the new_task page
  	When I fill in "Title" with "CS169 HW7"
  	When I fill in "task_release" with "2015-03-29 10:40: -07:00"
  	When I fill in "task_due" with "2015-04-06 20:25: -07:00"
  	When I select "New" from "Status"
  	When I select "Homework" from "Kind"
  	When I select "Computer Science 169" from "Course"
  	When I select "3" from "Rate"
  	And I press "Create Task"
  	Then I should see "Task was successfully created."
    When I follow "My Dashboard"
  	When I follow "My Status"
  	Then I should see "CS169 HW7" with the scope of "work_distribution_chart"