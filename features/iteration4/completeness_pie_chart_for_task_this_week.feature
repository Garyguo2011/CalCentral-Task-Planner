Feature: Completeness Pie chart for Task this week [Jinge]
As student in Berkeley
In order to show how many percent tasks left in this week
I want to create a Pie chart in status page to show the percentage complete this week

Background: users and tasks have been added to database
  
  Given it is currently Apr,1 2015
  
  Given the following users exist:
  | first_name | last_name | email                   | password  | 
  | Jinge      | Zhang     | zhangjinge588@gmail.com | 12345678  |
  | Rod        | Zhang     | zhangjinge0110@126.com  | 12345678  |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | rate | user_id | auto  |
  | HW1       | CS169  | Homework | 4/Jan/2015 23:59:00 -0800  | 6/Jan/2015 23:59:00 -0800  | New      |   1  | 1       | false |
  | PROJ1     | CS169  | Project  | 9/Apr/2015 23:59:00 -0800  | 16/Apr/2015 23:59:00 -0800 | New      |   2  | 1       | false |
  | ESSAY1    | CS195  | Paper    | 9/Apr/2015 23:59:00 -0800  | 31/Apr/2015 23:59:00 -0800 | Started  |   3  | 1       | false |
  | HW2       | CS186  | Homework | 27/Feb/2015 23:59:00 -0800 | 2/Apr/2015 23:59:00 -0800  | Started  |   4  | 2       | false |
  | MIDTERM1  | CS164  | Exam     | 1/Apr/2015 12:00:00 -8000  | 4/Apr/2015 16:00:00 -0800  | Finished |   5  | 2       | false |
  Given I am on the sign-in page
  And I sign in "zhangjinge588@gmail.com" with "12345678"
  Then I am on the home page

  Scenario: See the percentage of completeness
  	Given I am on the status page
    And I follow "Show finished tasks"
    And I should have completeness of "New" with percentage "40%"
    And I should have completeness of "Started" with percentage "40%"
  	And I should have completeness of "Finished" with percentage "20%"