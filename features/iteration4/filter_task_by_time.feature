Feature: Task can be filtered by time 

  As student in Berkeley
  In order not show tons of tasks at one big task
  I want to filter task by time as this week, this month, this year.    

Background: users and tasks have been added to database
  
  Given it is currently Apr,1 2015
  
  Given the following users exist:
  | first_name | last_name | email                 | password  | 
  | Xu         | He        | 123454321@hotmail.com | 123454321 |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | rate | user_id |
  | HW1       | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 6/Mar/2015 23:59:00 -0800  | New      | 1    | 1       |
  | PROJ1     | CS169  | Project  | 9/Mar/2015 23:59:00 -0800  | 16/Mar/2015 23:59:00 -0800 | New      | 2    | 1       |
  | ESSAY1    | CS195  | Paper    | 9/Mar/2015 23:59:00 -0800  | 31/Mar/2015 23:59:00 -0800 | Started  | 3    | 1       |
  | HW2       | CS186  | Homework | 27/Feb/2014 23:59:00 -0800 | 2/Mar/2014 23:59:00 -0800  | Started  | 4    | 1       |
  | MIDTERM1  | CS164  | Exam     | 1/Mar/2015 12:00:00 -8000  | 1/Apr/2015 16:00:00 -0800  | Finished | 5    | 1       |

  And I am on the sign-in page
  And I sign in "123454321@hotmail.com" with "123454321"

Scenario: show tasks in this week.
  Given I am currently on the status page
  When I select "this week" to filter
  Then I should see "ESSAY1"

Scenario: show tasks in this month.
  Given I am currently on the status page
  When I select "this month" to filter

Scenario: show tasks in this year.
  Given I am currently on the status page
  When I select "this year" to filter
  Then I should see "HW1"
  Then I should see "PROJ1"
  Then I should see "ESSAY1"
  Then I should not see "HW2"

Scenario: show tasks in all time.
  Given I am currently on the status page
  When I select "all time" to filter
  Then I should see "HW1"
  Then I should see "PROJ1"
  Then I should see "ESSAY1"
  Then I should see "HW2"
