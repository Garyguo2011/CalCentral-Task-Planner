Feature: Only Owner can see his/her Task
 
  As a authentic user 
  So that I can only manage my task
  I want to view my own task 

Background: tasks have been added to database

  Given the following task exist:
  | title                   | status     | due_date         |  owner 
  | CS164 Proj1             | Started    | 9-March-2015     |  ZhangJinge
  | CS169 HW5               | Started    | 17-March-2015    |  ZhangJinge 
  | CS161 Proj1             | Finished   | 1-March-2015     |  ZhangJinge 
  | Math113 HW2             | New        | 1-March-2015     |  HaoFu 
  
Scenario:  Only view my task
  Given I am on the task home page with user ZhangJinge
  And I press "Refresh"
  Then I should not see "Math113 HW2" 
  Then I should see the following: "CS164 Proj1", "CS169 HW5", "CS161 Proj1" 

Scenario:  
  I am on the task home page with user HaoFu
  And I press "Refresh"
  Then I should see "Math113 HW2" 
  Then I should not see the following: "CS164 Proj1", "CS169 HW5", "CS161 Proj1" 






  
