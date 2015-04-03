Feature: display list of tasks filtered by different criteria
 
  As student in Berkeley
  So that I can keep track of my status of my task
  I want to change task status in dashboard (change new task to be ongoing task)

Background: users and tasks have been added to database
  
  Given the following users exist:
  | first_name | last_name | email                   | password  | 
  | Xu         | He        | 123454321@hotmail.com   | 123454321 |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | rate | user_id |
  | HW1       | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 6/Sep/2015 23:59:00 -0800  | New      |   1  | 1       |
  | PROJ1     | CS169  | Project  | 9/Mar/2015 23:59:00 -0800  | 16/Mar/2015 23:59:00 -0800 | New      |   2  | 1       |
  | ESSAY1    | CS195  | Paper    | 9/Mar/2015 23:59:00 -0800  | 31/Mar/2015 23:59:00 -0800 | Finished |   3  | 1       |
  | HW2       | CS186  | Homework | 27/Feb/2015 23:59:00 -0800 | 20/May/2015 23:59:00 -0800 | Started  |   4  | 1       |
  | MIDTERM1  | CS164  | Exam     | 1/Mar/2015 12:00:00 -8000  | 1/Apr/2015 16:00:00 -0800  | Finished |   5  | 1       |

  And I am on the sign-in page
  And I sign in "123454321@hotmail.com" with "123454321"
  And it is currently Mar,15 2015

Scenario: change status from New to Started
  When I am on the tasks page
  And I click "Start" of "HW1" section
  Then I should see "Started" with the scope of "CS169_HW1"

Scenario: change status from Started to Finished
  When I am on the tasks page
  Then I click "Finish" of "HW2" section
  Then I should not see "HW2"
  When I follow "Show finished tasks"
  Then I should see "Finished" with the scope of "CS186_HW2"

Scenario: change status from Finished to Started
  When I am on the tasks page
  Then I follow "Show finished tasks"
  Then I should see "Reopen" with the scope of "CS195_ESSAY1"
  Then I click "Reopen" of "ESSAY1" section
  Then I should see "Started" with the scope of "CS195_ESSAY1"

Scenario: change status from Past due to Finished
  When I am on the tasks page
  Then I click "Finish" of "PROJ1" section
  And I follow "Show finished tasks"
  Then I should see "Finished" with the scope of "CS169_PROJ1"

