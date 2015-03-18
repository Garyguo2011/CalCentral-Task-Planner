Feature: display list of tasks filtered by different criteria
 
  As student in Berkeley
  So that I can keep track of my status of my task
  I want to change task status in dashboard (change new task to be ongoing task)

Background: users and tasks have been added to database
  
  Given the following users exist:
  | first_name | last_name | email                 | password  | 
  | Xu         | He        | 123454321@hotmail.com | 123454321 |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | user_id |
  | HW1       | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 1/Apr/2015 23:59:00 -0800  | New      | 1       |
  | PROJ1     | CS169  | Project  | 9/Mar/2015 23:59:00 -0800  | 16/Apr/2015 23:59:00 -0800 | New      | 1       |
  | ESSAY1    | CS195  | Paper    | 9/Mar/2015 23:59:00 -0800  | 31/Mar/2015 23:59:00 -0800 | Started  | 1       |
  | HW2       | CS186  | Homework | 27/Feb/2015 23:59:00 -0800 | 2/Apr/2015 23:59:00 -0800  | Started  | 1       |
  | MIDTERM1  | CS164  | Exam     | 1/Mar/2015 12:00:00 -8000  | 1/Apr/2015 16:00:00 -0800  | Finished | 1       |

  And I am on the sign-in page
  And I sign in "123454321@hotmail.com" with "123454321"

Scenario: I can see corresponding start or finish button for each task
  When I am on homepage
  And I follow "Show all tasks"
  Then I should see "Start" within "HW1" section
  And I should see "Finish" within "HW2" section
  And I should not see "Start" within "MIDTERM1" section
  And I should not see "Finish" within "MIDTERM1" section

Scenario: when click a start/finsh button, the corresponding task should change its status
  When I am on homepage
  And I click "Start" within "HW1" section
  Then I should see "Started" within "HW1" section
  When I click "Finish" within "HW2" section
  Then I should not see "HW2"
  When I follow "Show all tasks"
  Then I should see "Finished" within "HW2" section
