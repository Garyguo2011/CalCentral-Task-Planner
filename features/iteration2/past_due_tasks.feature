Feature: display list of tasks filtered by different criteria
 
  As student in Berkeley
  So that I can make past due task to the most high priority task
  I want to automatically change task status to past due once i pass due date


Background: users and tasks have been added to database
  
  Given the following users exist:
  | first_name | last_name | email                 | password  | 
  | Xu         | He        | 123454321@hotmail.com | 123454321 |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | user_id | rate |
  | HW1       | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 30/Mar/2015 23:59:00 -0800 | New      | 1       | 1    |
  | PROJ1     | CS169  | Project  | 9/Mar/2015 23:59:00 -0800  | 5/Apr/2015 23:59:00 -0800  | New      | 1       | 1    |
  | MIDTERM1  | CS164  | Exam     | 1/Mar/2015 12:00:00 -8000  | 1/Apr/2015 16:00:00 -0800  | Ongoing  | 1       | 1    |

  And I am on the sign-in page
  And I sign in "123454321@hotmail.com" with "123454321"
  And it is currently Mar,31 2015

Scenario: all the unifinished past due tasks should automatically change status
  Given it is currently Mar,14 2015
  Then I should see the following HW1,PROJ1,MIDTERM1
  And I should see "HW1" with the scope of "low"
  Given it is currently Mar,31 2015
  Then I should see "HW1" with the scope of "high"
  And I should see "PROJ1" before "HW1"
