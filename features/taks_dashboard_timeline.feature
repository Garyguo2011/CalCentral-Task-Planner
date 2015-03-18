Feature: Task Dashboard Timeline
  As a student at UC Berkeley
  In order to view tasks more graphically in terms of time
  I want to have a horizontal timeline to view my tasks

  Background: 
    Given the following tasks exist:
    | title          | type     | class  | due_date   |
    | Read Chapter 4 | Homework | CS 162 | 03/17/2015 |
    | Hello, world!  | Homework | CS 162 | 03/31/2015 |
    | Exam #2        | Exam     | CS 169 | 03/19/2015 |
    | Checkpoint #2  | Project  | CS 169 | 03/18/2015 |

  Scenario: Viewing the task timeline
    Given I am on the home page
    Then I should see "Read Chapter 4" before "Checkpoint #2"
    And I should see "Checkpoint #2" before "Exam #2"
    And I should see "Exam #2 before "Hello, world!"

  Scenario: Add a task to the timeline
    Given I am on the home page
    And I press "Add a Task"
    Then I should be on the new task page
    When I fill in "Project #2" for "title"
    And I fill in "3/30/2015" for "due_date"
    And I press "Create"
    Then I should be on the home page
    And I should see "Exam #2" before "Project #2"
    And I should see "Project #2" before "Hello, world!"

  Scenario: Delete a task from the timeline
    Given I am on the home page
    And I follow "Exam #2"
    And I press "Delete"
    Then I should be on the home page
    And I should see "Checkpoint #2" before "Hello,world"
    And I should not see "Exam #2"

