Feature: display list of tasks filtered by different criteria
 
  As staff of CalCentral
  In order to make the task planner a part of the whole CalCentral dashboard
  We want to integrate new components (Task List and Task Timeline) to current existing widgets

Background: users and tasks have been added to database
  
  Given it is currently Apr,1 2015
  
  Given the following users exist:
  | first_name | last_name | email                 | password  | 
  | Xu         | He        | 123454321@hotmail.com | 123454321 |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | user_id | rate |
  | HW1       | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 1/Apr/2015 23:59:00 -0800  | New      | 1       | 1    |
  | PROJ1     | CS169  | Project  | 9/Mar/2015 23:59:00 -0800  | 16/Apr/2015 23:59:00 -0800 | New      | 1       | 1    |
  | ESSAY1    | CS195  | Paper    | 9/Mar/2015 23:59:00 -0800  | 12/Mar/2015 23:59:00 -0800 | Started  | 1       | 1    |
  | HW2       | CS186  | Homework | 27/Feb/2015 23:59:00 -0800 | 2/Apr/2015 23:59:00 -0800  | Started  | 1       | 1    |
  | MIDTERM1  | CS164  | Exam     | 1/Mar/2015 12:00:00 -8000  | 1/Apr/2015 16:00:00 -0800  | Finished | 1       | 1    |

  And I am on the sign-in page
  And I sign in "123454321@hotmail.com" with "123454321"
  
Scenario: view a task timeline using the CalCentral dashboard
  Given I am on the tasks page
  Then I should see "CalCentral"
  And I should see "To Do"

  When I follow "Task Timeline"
  And I should see "To Do"
  And I should not see "Tasks"
  And I should see "Timeline"
  And I should see "ESSAY1" with the scope of "Timeline"

Scenario: view a task list using the CalCentral dashboard
  Given I am on the tasks page
  Then I should see "CalCentral"
  And I should see "To Do"

  When I follow "Task List"
  And I should see "To Do"
  And I should see "Tasks"
  And I should not see "Timeline"
  And I should see "ESSAY1" with the scope of "task_title"
  
