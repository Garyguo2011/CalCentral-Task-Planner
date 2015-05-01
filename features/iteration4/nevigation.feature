Feature: Navigation Menu for Task planner

As student in Berkeley
In order to navigate my Calendar, my status, and my tasks easier
I want to create a navigation menu above TO DO section

Background: users and tasks have been added to database
  
  Given it is currently Mar,31 2015
  
  Given the following users exist:
  | first_name | last_name | email                 | password  | 
  | Xu         | He        | 123454321@hotmail.com | 123454321 |

  And I am on the sign-in page
  And I sign in "123454321@hotmail.com" with "123454321"
  Given I am currently on the dashboard page

Scenario: Nevigation menu should take me to exact page
  When I follow "My Tasks"
  Then I should be on the tasks page

  When I follow "My Dashboard"
  Then I should be on the dashboard page

  When I follow "My Calendar"
  Then I should be on the calendar page

  When I follow "My Dashboard"
  When I follow "My Status"
  Then I should be on the status page
