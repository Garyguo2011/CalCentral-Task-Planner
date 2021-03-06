Feature: CalCentral Dummy Data Generator [Jinge] -- cucumber test
As Staff of CalCentral
In order to let user quickly get used to our task planner
We want to create a Dummy Data Generator to create dummy tasks as example of app

Background: users and tasks have been added to database
  
  Given it is currently Apr,1 2015
  
  Given the following users exist:
  | first_name | last_name | email                   | password  | 
  | Jinge      | Zhang     | zhangjinge588@gmail.com | 12345678  |
  | Rod        | Zhang     | zhangjinge0110@126.com  | 12345678  |

  Given I am on the sign-in page
  And I sign in "zhangjinge588@gmail.com" with "12345678"
  Then I am on the home page

  Scenario: Auto-generate tasks
  Given I am on the status page
  When I follow "Generate Task"
  Then I should see more than 0 tasks

  Scenario: Delete all auto-generated tasks
  Given I am on the status page
  When I follow "Generate Task"
  And I follow "Delete Generate Task"
  Then I should not see any tasks