Feature: Workload Column Chart  [Jinge, Gary, Hao]
As student in Berkeley
So that I could visualize the workload of my current tasks
I want to see a column chart which represents estimate workload in term of days/weeks.

Background: users and tasks have been added to database
  
  Given the following users exist:
  | first_name | last_name | email                   | password  | 
  | Jinge      | Zhang     | zhangjinge588@gmail.com | 12345678  |
  | Rod        | Zhang     | zhangjinge0110@126.com  | 12345678  |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | rate | user_id |
  | HW1       | CS169  | Homework | 4/Jan/2015 23:59:00 -0800  | 6/Jan/2015 23:59:00 -0800  | New      |   1  | 1       |
  | PROJ1     | CS169  | Project  | 9/Apr/2015 23:59:00 -0800  | 16/Apr/2015 23:59:00 -0800 | New      |   2  | 1       |
  | ESSAY1    | CS195  | Paper    | 9/Apr/2015 23:59:00 -0800  | 31/Apr/2015 23:59:00 -0800 | Started  |   3  | 1       |
  | HW2       | CS186  | Homework | 27/Feb/2015 23:59:00 -0800 | 2/Apr/2015 23:59:00 -0800  | Started  |   4  | 2       |
  | MIDTERM1  | CS164  | Exam     | 1/Apr/2015 12:00:00 -8000  | 4/Apr/2015 16:00:00 -0800  | Finished |   5  | 2       |


Scenario: visualize my current task through column chart
  Given it is currently Apr,1 2015 
  Given I am on the sign-in page
  And I sign in "zhangjinge588@gmail.com" with "12345678"
  Then I am on the home page 
  Then I should see "PROJ1" with the scope of "work_distribution_chart"
  Then I should not see "HW1" with the scope of "work_distribution_chart"


Scenario: visualize my current task through column chart given another time
  Given it is currently Jan,1 2015 
  Given I am on the sign-in page
  And I sign in "zhangjinge588@gmail.com" with "12345678"
  Then I am on the home page 
  Then I should not see "PROJ1" with the scope of "work_distribution_chart"
  Then I should see "HW1" with the scope of "work_distribution_chart"

 






