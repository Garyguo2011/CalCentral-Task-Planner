Feature: display remaining time for each single task
 
  As a student in UC Berkeley
  So that i can view all my assignments remaining time
  I want to have a figure showing how much time assignment left

Background: tasks have been added to database 

  Given the following tasks exist:
  | title     | course | due                     | status  | owner |
  | HW1       | CS169  | 2015-03-25 11:59pm PDT  | New     | Xu He |
  | PROJ1     | CS169  | 2015-03-26 11:59pm PDT  | Ongoing | Xu He |
  | ESSAY1    | CS195  | 2015-04-01 6:00pm PDT   | New     | Xu He |
  | HW2       | CS186  | 2015-03-10 11:59pm PDT  | Ongoing | Xu He |
  | MIDTERM1  | CS164  | 2015-03-04 10:00am PDT  | New     | Xu He |

Scenario: be able see remaining time for each single task
 	When I am on Task-Planner home page
 	And the current time is 2015-03-04 8:00am PDT
 	And I press "MIDTERM1" tab
 	Then I should see the remaining time is 2:00