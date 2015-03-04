Feature: display list of tasks filtered by different criteria
 
  As a student in UC Berkeley
  So that I can quickly browse tasks based on my preference
  I want to see tasks filtered by course status

Background: tasks have been added to database

  Given the following tasks exist:
  | title     | course | due                     | status  | owner |
  | HW1       | CS169  | 2015-03-25 11:59pm PDT  | New     | Xu He |
  | PROJ1     | CS169  | 2015-03-26 11:59pm PDT  | Ongoing | Xu He |
  | ESSAY1    | CS195  | 2015-04-01 6:00pm PDT   | New     | Xu He |
  | HW2       | CS186  | 2015-03-10 11:59pm PDT  | Ongoing | Xu He |
  | MIDTERM1  | CS164  | 2015-03-04 10:00am PDT  | New     | Xu He |

  And  I am on the Task-Planner home page

Scenario: Each task goes to different list based on status
  When I press "Refresh"
  Then I should see "HW1" in New list
  And I should see "ESSAY1" in New list
  And I should see "MIDTERM1" in New list
  And I should see "PROJ1" in Ongoing list
  And I should see "HW2" in Ongoing list 

Scenario: restrict to tasks in CS169 and CS164
  When I check the following courses: CS169,CS164
  And I uncheck the following courses: CS186, CS185
  And I press "Refresh"
  Then I should see "HW1" in New list
  And I should see "PROJ1" in Ongoing list
  And I should see "MIDTERM1" in New list
  And I should not see "ESSAY1" in New list
  And I should not see "HW2" in Ongoing list


Scenario: all courses selected
  When I check the following courses: CS169,CS164,CS195,CS186
  And I press "Refresh"
  Then I should see all the courses
