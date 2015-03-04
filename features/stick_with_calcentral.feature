Feature: the new web application should reside in the current CalCentral website
 
  As staff in UC Berkeley
  So that i can integrate the Task Manger Feature to CalCentral Platform
  I want to see the app resides in the current website


Scenario: I am on CalCentral home page to reach Task Planner
  Given I am on CalCentral home page
  And I press "My Tasks"
  Then I should be on Task-Planner home page
  When I press "CalCentral Homepage"
  Then I should be on Calcentral home page