Feature: display list of tasks sorted by different criteria
 
  As a student in UC Berkeley
  So that I can quickly browse my current tasks based on my preferences
  I want to see tasks sorted by due date

Background: tasks have been added to database
  
  Given the following tasks exist:
  | title     | course | due                     | status  | owner |
  | HW1       | CS169  | 2015-03-25 11:59pm PDT  | New     | Xu He |
  | PROJ1     | CS169  | 2015-03-26 11:59pm PDT  | Ongoing | Xu He |
  | ESSAY1    | CS195  | 2015-04-01 6:00pm PDT   | New     | Xu He |
  | HW2       | CS186  | 2015-03-10 11:59pm PDT  | Ongoing | Xu He |
  | MIDTERM1  | CS164  | 2015-03-04 10:00am PDT  | New     | Xu He |

  And I am on the Task-Planner home page

Scenario: sort tasks in increasing order of due date
  When I follow "Task Title"
  Then I should see "MIDTERM1" before "HW1" in New list
  And I should see "MIDTERM1" before "ESSAY1" in New list
  And I should see "HW2" before "PROJ1" in Ongoing list
