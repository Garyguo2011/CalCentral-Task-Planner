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
  | title     | course | kind     | release                    | due                        | status   | rate  | user_id |
  | HW1       | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 6/Mar/2015 23:59:00 -0800  | New      | 1     | 1       |
  | PROJ1     | CS169  | Project  | 9/Mar/2015 23:59:00 -0800  | 16/Mar/2015 23:59:00 -0800 | New      | 1     | 1       |
  | ESSAY1    | CS195  | Paper    | 9/Mar/2015 23:59:00 -0800  | 31/Mar/2015 23:59:00 -0800 | Started  | 1     | 1       |
  | HW2       | CS186  | Homework | 27/Feb/2015 23:59:00 -0800 | 2/Mar/2015 23:59:00 -0800  | Started  | 2     | 2       |
  | MIDTERM1  | CS164  | Exam     | 1/Mar/2015 12:00:00 -8000  | 1/Apr/2015 16:00:00 -0800  | Finished | 2     | 2       |

  Given I am currently on the sign-in page
  When I sign in "zhangjinge588@gmail.com" with "12345678"

Scenario: add task with CS169 HW, 3/15/2015
  When I follow "Add new task"
  When I fill in the following: 
      |Title       | CS169 HW |
      |task_release| 2015-03-29 10:40: -07:00|
      |task_due    | 2015-03-29 20:25: -07:00| 
  When I select the following: 
      |New                  | Status | 
      |Homework             | Kind   |
      |Computer Science 169 | Course |
      |3                    | Rate   |
  And I press "Create Task"
  Then I should see "Task was successfully created."

Scenario: add task (sad path)
  When I follow "Add new task"
  When I fill in the following: 
      |Title       | CS169 HW |
      |task_release| 2015-03-29 10:40: -07:00|
      |task_due    | 2015-03-29 20:25: -07:00| 
  When I select the following: 
      |3                    | Rate   |
      |Computer Science 169 | Course |
  And I press "Create Task"
  Then I should see "errors prohibited this task from being saved"
  
Scenario: Read/Edit task
  When I follow "HW1"
  Then I should see "HW1"
  When I press "Edit Task"
  Then I should see "Editing task"
  Then I would see "HW1" in my "Title"
  When I fill in "Title" with "CS169 HW1"
  Then I press "Update Task"
  Then I should see "Task was successfully updated."
  When I press "Back List"
  Then I should see "CS169 HW1"

Scenario: Read/Delete task
  When I follow "HW1"
  When I press "Delete"
  Then I should currently on the home page
  Then I should not see "HW1"

