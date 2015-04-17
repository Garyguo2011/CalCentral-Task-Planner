Feature: Task Alert Message

  As student in Berkeley
  In order to keep knowing a task current situation
  I want to see an alert message for task basic on time usage and status

Background: users and tasks have been added to database
  
  Given it is currently Apr,5 2015

  Given the following users exist:
  | first_name | last_name | email                   | password  | 
  | Xinran     | Guo       | xinran@gmail.com        | 111111111 |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | rate  | user_id |
  | Typo-blog | CS169  | Homework | 29/Mar/2015 23:59:00 -0800 | 6/Apr/2015 00:59:00 -0800  | New      | 1     | 1       |
  | Homework6 | CS164  | Homework | 1/Apr/2015 23:59:00 -0800  | 4/Apr/2015 23:59:00 -0800  | New      | 5     | 1       |
  | Proj3     | CS186  | Project  | 1/Apr/2015 23:59:00 -0800  | 20/Apr/2015 23:59:00 -0800 | Started  | 3     | 1       |
  | Quiz9     | CS164  | Exam     | 1/Apr/2015 23:59:00 -0800  | 20/Apr/2015 23:59:00 -0800 | New      | 5     | 1       |
  | Essay2    | CS164  | Paper    | 1/Apr/2015 23:59:00 -0800  | 20/Apr/2015 23:59:00 -0800 | Finished | 5     | 1       |
  
  And I am on the sign-in page
  Given I sign in "xinran@gmail.com" with "111111111"
  Given I am on the tasks page
  
Scenario: Red (Danger) alert message for >90% time usage
  Given it is currently Apr,5 2015
  When I follow "Typo-blog"
  Then I should be on the detail page for "Typo-blog"
  Then I should see "Hurry up! Typo-blog have used 92% of Time, is due about 14 hours"

Scenario: Red (Danger) alert message for past due task
  Given it is currently Apr,5 2015
  When I follow "Homework6"
  Then I should be on the detail page for "Homework6"
  Then I should see "Code Red! Homework6 have passed Due. Please finish ASAP!!!"

Scenario: Yellow (Warning) alert message for >70% time usage task
  Given it is currently Apr,15 2015
  When I follow "Proj3"
  Then I should be on the detail page for "Proj3"
  Then I should see "Hurry up! Proj3 is due 6 days"

Scenario: Yellow (Warning) alert message for >50% time usage unstart task
  Given it is currently Apr,14 2015
  When I follow "Quiz9"
  Then I should be on the detail page for "Quiz9"
  Then I should see "Head up! You have pass half of time, but you haven't started!"

Scenario: Green (Health) alert message for 30% time usage start task
  Given it is currently Apr,8 2015
  When I follow "Proj3"
  Then I should be on the detail page for "Proj3"
  Then I should see "Keep it up! You are early bird!"

Scenario: Green (Health) alert message for finish task
  Given it is currently Apr,2 2015
  Given I am on the detail page for "Essay2"
  Then I should see "Nice work, you have completed task."
