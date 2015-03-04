Feature: Integrate with Google task 
 
  As a authentic user 
  So that I can import task from Google account to My task.
  I want to sync up with my Google Task

Background: task have been added to database

  Given the following task exist:
  | title                   | status     | due_date         |  owner 
  | CS164 Proj1             | Started    | 9-March-2015     |  ZhangJinge
  | CS169 HW5               | Started    | 17-March-2015    |  ZhangJinge 
  | CS161 Proj1             | Finished   | 1-March-2015     |  ZhangJinge 
  | Math113 HW2             | Finished   | 1-March-2015     |  HaoFu  


And  I am on the task home page with user ZhangJinge with Google account verfied. 

Scenario:  Import from google task to my task.
  Given user's Google Account 
  When I follow "Google task Import"
  Then I press "CS160 HW"
  And I press "Refresh"
  Then I should see the following: "CS164 Proj1", "CS169 HW5", "CS161 Proj1", "CS160 HW" 
  
  