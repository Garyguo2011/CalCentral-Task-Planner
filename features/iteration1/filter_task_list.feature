Feature: display list of tasks filtered by different criteria
 
  As a student in UC Berkeley
  So that I can quickly browse tasks based on my preference
  I want to see tasks filtered by course status

Background: users and tasks have been added to database
  
  Given the following users exist:
  | first_name | last_name | email                 | password  | 
  | Xu         | He        | 123454321@hotmail.com | 123454321 |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | rate | user_id |
  | HW1       | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 6/Mar/2015 23:59:00 -0800  | New      | 1    | 1       |
  | PROJ1     | CS169  | Project  | 9/Mar/2015 23:59:00 -0800  | 16/Mar/2015 23:59:00 -0800 | New      | 2    | 1       |
  | ESSAY1    | CS195  | Paper    | 9/Mar/2015 23:59:00 -0800  | 31/Mar/2015 23:59:00 -0800 | Started  | 3    | 1       |
  | HW2       | CS186  | Homework | 27/Feb/2015 23:59:00 -0800 | 2/Mar/2015 23:59:00 -0800  | Started  | 4    | 1       |
  | MIDTERM1  | CS164  | Exam     | 1/Mar/2015 12:00:00 -8000  | 1/Apr/2015 16:00:00 -0800  | Finished | 5    | 1       |

  And I am on the sign-in page
  And I sign in "123454321@hotmail.com" with "123454321"

Scenario: originally hide the finished tasks
  Then I should not see "MIDTERM1"
  When I follow "Show finished tasks"
  Then I should see all the tasks
  When I follow "Hide finished tasks"
  Then I should not see "MIDTERM1"

Scenario: filter the tasks based on types
  When I am on Project filter page
  And I follow "Show finished tasks"
  Then I should see "MIDTERM1"
  When I am on Show All page
  And I follow "Show finished tasks"
  Then I should see all the tasks
