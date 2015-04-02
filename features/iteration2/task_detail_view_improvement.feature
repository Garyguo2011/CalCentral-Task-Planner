Feature: Task Detail View Improvement
  As a student at UC Berkeley
  So that I can see the ramaining unfinished subtasks
  I want to see the a progress bar of my subtasks' completeness

  Background: 
    Given the following users exist:
    | first_name | last_name | email            | password  | 
    | Xinran     | Guo       | xinran@gmail.com | 111111111 |
    | Xu         | He        | xu@ibearHost.com | 111111111 |

    Given the following tasks exist:
    | title    | course | kind     | release                    | due                        | status   | rate | user_id |
    | Task 1   | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 6/Mar/2015 23:59:00 -0800  | New      | 1    | 1       |
    | Task 2   | CS188  | Project  | 3/Mar/2015 23:59:00 -0800  | 16/Mar/2015 23:59:00 -0800 | New      | 2    | 1       |
    | Task 3   | CS188  | Quiz     | 3/Mar/2015 23:59:00 -0800  | 16/Mar/2015 23:59:00 -0800 | New      | 3    | 1       |


    Given the following subtasks exist:
    | description      | is_done   | task_id |
    | Subtask 1        | true      | 2       |
    | Subtask 2        | false     | 2       |
    | Subtask 3        | true      | 2       |
    | Subtask 4        | true      | 2       |
    | Subtask 5        | false     | 1       |
    | Subtask 6        | true      | 1       |

    Given I am on the sign-in page
    And I sign in "xinran@gmail.com" with "111111111"

  Scenario: Check a given task's progress
    Given I am on the detail page for "Task 1"
    Then I should see "Task Progress Percentage"
    And I should see "50% Complete"

    Given I am on the detail page for "Task 2"
    Then I should see "Task Progress Percentage"
    And I should see "75% Complete"

    Given I am on the detail page for "Task 3"
    Then I should not see "Task Progress Percentage"

  Scenario: Update a given's task's progress
    Given I am on the detail page for "Task 2"
    Then I should see "Task Progress Percentage"
    And I should see "75% Complete"

    When I uncheck "Subtask 3" done
    And I press "Update" for "Subtask 3"

    Then I should be on the detail page for "Task 2"
    And I should see "Task Progress Percentage"
    And I should see "50% Complete"

  Scenario: No subtasks for a given task
    Given I am on the detail page for "Task 3"
    Then I should see "Please add subtask to show task progress"
    And I should not see "Task Progress Percentage"

  Scenario: Add a new subtask
    Given I am on the detail page for "Task 2"
    Then I should see "Task Progress Percentage"
    And I should see "75% Complete"

    When I add description for "New Subtask" to "Subtask 7"
    And I press "Create"

    Then I should be on the detail page for "Task 2"
    And I should see "Task Progress Percentage"
    And I should see "60% Complete"

  Scenario: Delete a subtask
    Given I am on the detail page for "Task 1"
    Then I should see "Task Progress Percentage"
    And I should see "50% Complete"

    When I press "Delete" for "Subtask 6"
    Then I should be on the detail page for "Task 1"
    And I should see "Task Progress Percentage"
    And I should see "0% Complete"


