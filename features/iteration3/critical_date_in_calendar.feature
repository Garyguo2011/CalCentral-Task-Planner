Feature: display task in calendar and move task on calendar
 
  As student in Berkeley
  I want to see my tasks and change them directly on calendar
  So that I can check or make change of my tasks easily

Background: users and tasks have been added to database
  
  Given it is currently Mar,15 2015
  
  Given the following users exist:
  | first_name | last_name | email                   | password  | 
  | Xu         | He        | 123454321@hotmail.com   | 123454321 |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | rate | user_id |
  | HW1       | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 6/Sep/2015 23:59:00 -0800  | New      |   1  | 1       |
  | PROJ1     | CS169  | Project  | 9/Mar/2015 23:59:00 -0800  | 14/Mar/2015 23:59:00 -0800 | New      |   2  | 1       |
  | ESSAY1    | CS195  | Paper    | 9/Mar/2015 23:59:00 -0800  | 31/Mar/2015 23:59:00 -0800 | Finished |   3  | 1       |
  | HW2       | CS186  | Homework | 27/Feb/2015 23:59:00 -0800 | 20/May/2015 23:59:00 -0800 | Started  |   4  | 1       |
  | MIDTERM1  | CS164  | Exam     | 1/Mar/2015 12:00:00 -8000  | 1/Apr/2015 16:00:00 -0800  | Finished |   5  | 1       |

  And I am on the sign-in page
  And I sign in "123454321@hotmail.com" with "123454321"

Scenario: change task in calendar
  When I am on the calendar page
  When I move "CS169 HW1" task to "5/Mar/2015 23:59:00 -0800"
