Feature: display list of tasks filtered by different criteria
 
  As student in Berkeley
  In order to view tasks more graphically in term of time
  I want to have a vertical timeline to view my tasks

Background: users and tasks have been added to database
  
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

Scenario: see a timeline with a sorted list of tasks
  When I am on the tasks page
  Then I should not see "MIDTERM1" with the scope of "Timeline"
  When I follow "Show finished tasks"
  Then I should not see "MIDTERM1" with the scope of "Timeline"
  And I can see "CS186 HW2" which in "CS186_HW2_timeslot" before "CS169 PROJ1" which in "CS169_PROJ1_timeslot" with the scope of "Timeline"
  And I can see "CS195 ESSAY1" which in "CS195_ESSAY1_timeslot" before "CS169 HW1" which in "CS169_HW1_timeslot" with the scope of "Timeline"
  
Scenario: see a table with a list of tasks grouped by status
  Given it is currently Mar,15 2015
  When I am on the tasks page
  Then I should see "HW1" with the scope of "low"
  And I should see "PROJ1" with the scope of "low"
  And I should see "ESSAY1" with the scope of "high"
  And I should see "HW2" with the scope of "medium"
