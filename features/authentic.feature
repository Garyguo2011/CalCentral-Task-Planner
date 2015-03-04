Feature: Only Owner can see his/her Task
 
  As a authentic user 
  So that I can only manage my task
  I want to view my own task 

Background: task have been added to database

  Given the following task exist:
  | title                   | status     | due_date         |  owner 
  | CS164 Proj1             | Started    | 9-March-2015     |  ZhangJinge
  | CS169 HW5               | Started    | 17-March-2015    |  ZhangJinge 
  | CS161 Proj1             | Finished   | 1-March-2015     |  ZhangJinge 
  | Math113 HW2             | Finished   | 1-March-2015     |  HaoFu 
  
 
Scenario: Sign up
  When I press "Sign up"
  I should on SIGN UP PAGE
  Then I fill in with "Jinge" as First name
  Then I fill in with "Zhang" as Last name
  Then I fill in with "zhangjinge588@gmail.com" as Email
  Then I fill in with "12345678" as password
  Then I fill in with "12345678" as password confirmation
  And I press "Sign up"
  Then I should see "Welcome! You have been signed up successfully."

Scenario:  Sign up with CalNet
  When I press "Sign up with CalNet"
  Then I should on CALNET AUTHENTICATION PAGE
  Then I press "Allow"
  Then I should see "Welcome! You have been signed up successfully."

Scenario:  Sign in
  When I press "Sign in"
  When I fill in with "zhangjinge588@gmail.com" as Email
  When I fill in with "12345678" as password
  I should on HOME PAGE
  I shoud see "you have been successfully logged in"
  Then I should see the following: "CS164 Proj1", "CS169 HW5", "CS161 Proj1" 
  Then I should not see "Math113 HW2" 

Scenario: Sign out
  When i press "Sign out"
  I shoud see "you have been successfully logged out"
  Then I should on LOG IN PAGE 








  
