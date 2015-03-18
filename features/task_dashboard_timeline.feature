Feature: display list of tasks filtered by different criteria
 
  As student in Berkeley
  In order to view tasks more graphically in term of time
  I want to have a vertical timeline to view my tasks

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

Scenario: see a timeline with a sorted list of tasks
  When I am on homepage
  Then I should not see "MIDTERM1" within "Timeline" section
  Then I should see "HW2" before "PROJ1" within "Timeline" section
  And I should see "ESSAY1" before "HW1" within "Timeline" section
  When I follow "Show all tasks"
  Then I should not see "MIDTERM1" within "Timeline" section
