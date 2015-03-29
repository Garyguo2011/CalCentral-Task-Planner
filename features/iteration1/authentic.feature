Feature: Only Owner can see his/her Task
 
  As an authentic user 
  So that I can only manage my task
  I want to view my own task 

Background: users and tasks have been added to database
  
  Given the following users exist:
  | first_name | last_name | email                   | password  | 
  | Jinge      | Zhang     | zhangjinge588@gmail.com | 12345678  |
  | Rod        | Zhang     | zhangjinge0110@126.com  | 12345678  |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | user_id |
  | HW1       | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 6/Mar/2015 23:59:00 -0800  | New      | 1       |
  | PROJ1     | CS169  | Project  | 9/Mar/2015 23:59:00 -0800  | 16/Mar/2015 23:59:00 -0800 | New      | 1       |
  | ESSAY1    | CS195  | Paper    | 9/Mar/2015 23:59:00 -0800  | 31/Mar/2015 23:59:00 -0800 | Started  | 1       |
  | HW2       | CS186  | Homework | 27/Feb/2015 23:59:00 -0800 | 2/Mar/2015 23:59:00 -0800  | Started  | 2       |
  | MIDTERM1  | CS164  | Exam     | 1/Mar/2015 12:00:00 -8000  | 1/Apr/2015 16:00:00 -0800  | Finished | 2       |
  
 
Scenario: Sign up
  Given I am currently on the sign-in page
  When I follow "Sign up"
  When I fill in "First name" with "Jinge"
  When I fill in "Last name" with "Zhang"
  When I fill in "Email" with "jingezhang@berkeley.edu"
  When I fill in "Password" with "12345678"
  When I fill in "Password confirmation" with "12345678"
  And I press "Sign up"
  Then I should see "Jinge Zhang"

Scenario:  Sign in
  Given I am currently on the sign-in page
  When I fill in "Email" with "zhangjinge588@gmail.com"
  When I fill in "user_password" with "12345678"
  When I press "Log in"
  Then I should see "Jinge Zhang"
  Then I should see "ESSAY1"
  Then I should see "HW1"
  Then I should see "PROJ1" 
  Then I should not see "HW2"
  Then I should not see "MIDTERM1"

Scenario: User only view its own task, with finished tasks filtered out initally
  Given I am currently on the sign-in page
  When I fill in "Email" with "zhangjinge0110@126.com"
  When I fill in "user_password" with "12345678"
  When I press "Log in"
  Then I should see "Rod Zhang"
  Then I should not see "ESSAY1"
  Then I should not see "HW1"
  Then I should not see "PROJ1" 
  Then I should see "HW2"
  Then I should not see "MIDTERM1"
  When I follow "Show finished tasks"
  Then I should see "HW2"
  Then I should see "MIDTERM1"
  When I follow "Hide finished tasks"
  Then I should see "HW2"
  Then I should not see "MIDTERM1" 
Scenario: Sign out
  Given I am currently on the sign-in page
  When I fill in "Email" with "zhangjinge588@gmail.com"
  When I fill in "user_password" with "12345678"
  When I press "Log in"
  Then I should see "Jinge Zhang"
  When I follow "Sign Out"
  Then I should currently on the sign-in page 
