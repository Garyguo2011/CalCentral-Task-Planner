Feature: Rate My Task
  As a student at UC Berkeley
  In order to reserve proper time to finish a task
  I want to rate my task difficulty from 1 to 5

  Background: 
    Given the following tasks exist:
    | title          | type     | rating |
    | Read Chapter 4 | Homework |        |
    | Hello, world!  | Homework | 3      |

  Scenario: Add a rating to a task
    Given I am on the view task page for "Read Chapter 4"
    And I fill in "2" for "rating"
    And I press "Update"
    Then I should be on the home page
    And I should see the rating "2" for "Read Chapter 4"

  Scenario: Change a rating for a task
    Given I am on the home page
    Then I should see the rating "3" for "Hello, world!"
    When I follow "Hello, world!"
    Then I should be on the view task page for "Hello, world!"
    When I fill in "4" for "rating"
    And I press "Update"
    Then I should be on the home page
    And I should see the rating "4" for "Hello, world!"

