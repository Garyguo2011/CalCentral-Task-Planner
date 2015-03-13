Feature: CRUD a Task
 
  As a concerned student
  So that I can quickly browse task appropriate for my academic purpose
  I want to create/edit/delete tasks

Background: users and tasks have been added to database
  
  Given the following users exist:
  | first_name | last_name | email                   | password  | 
  | Jinge      | Zhang     | zhangjinge588@gmail.com | 12345678  |
  | Rod        | Zhang     | zhangjinge0110@126.com  | 12345678  |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | user_id |
  | HW1       | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 6/Mar/2015 23:59:00 -0800  | New      | 1       |
  | PROJ1     | CS169  | Project  | 9/Mar/2015 23:59:00 -0800  | 16/Mar/2015 23:59:00 -0800 | New      | 1       |
  | ESSAY1    | CS195  | Paper    | 9/Mar/2015 23:59:00 -0800  | 31/Mar/2015 23:59:00 -0800 | Started  | 1       |
  | HW2       | CS186  | Homework | 27/Feb/2015 23:59:00 -0800 | 2/Mar/2015 23:59:00 -0800  | Started  | 2       |
  | MIDTERM1  | CS164  | Exam     | 1/Mar/2015 12:00:00 -8000  | 1/Apr/2015 16:00:00 -0800  | Finished | 2       |
  

Scenario:  add task with CS169 HW, 3/13/2015
  Given I am currently on the sign_in page
  When I fill in "Email" with "zhangjinge588@gmail.com"
  When I fill in "user_password" with "12345678"
  When I press "Log in"
  Then I should see "Jinge Zhang"
  When I follow "Add new Task"
  Then I should currently on the new_task page
  When I fill in "Title" with "CS169 HW"
  When I select in "task_due_1i" with "2015"
  When I select in "task_due_2i" with "March"
  When I select in "task_due_3i"
  

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

