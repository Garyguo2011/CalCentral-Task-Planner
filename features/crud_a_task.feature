Feature: CRUD a Task
 
  As a concerned student
  So that I can quickly browse task appropriate for my academic purpose
  I want to create/edit/delete tasks

Background: task have been added to database

  Given the following task exist:
  | title                   | status     | due_date         |  owner 
  | CS164 Proj1             | Started    | 9-March-2015     |  ZhangJinge
  | CS169 HW5               | Started    | 17-March-2015    |  ZhangJinge 
  | CS161 Proj1             | Finished   | 1-March-2015     |  ZhangJinge 
 
 
  And  I am on the task home page

Scenario:  add task with CS169 HW, 3/13/2015 
  When I type "CS169 HW " in the add task field
  And I select Due Date "3/13/2015"
  Then I select Status "Started"
  And I press "Add"
  Then I should see "CS169 HW, 13-March-2015"
  

Scenario: Delate task
  When I check delate on "CS169 HW, 13-March-2015"
  And I press "Refresh"
  Then I should not see "CS169 HW, 13-March-2015"


Scenario: Edit task
  When I type "CS161 HW" on "CS169 HW, 13-March-2015"
  And I press "Refresh"
  Then I should see "CS161 HW, 13-March-2015" 
  When I select Due Date "3/15/2015"
  Then I should see "CS161 HW, 15-March-2015" 

