Feature: Multiple bloggers
  As a student at UC Berkeley
  So that I can see the ramaining unfinished subtasks
  I want to see the a progress bar of my subtasks' completeness

  Background: 
    Given the following subtasks exist:
    | title                  | task          | is_done   |
    | Create hello.c         | Hello, world! | checked   |
    | Write main function    | Hello, world! | checked   |
    | Write a makefile       | Hello, world! | unchecked |
    | Commit to git repo     | Hello, world! | unchecked |
    | Submit homework online | Hello, world! | unchecked |

  Scenario: Check a given task's progress
    Given I am on the view task page for "Hello, world!"
    Then I should see "40% Complete"
    And the value of "progress" should be "0.40"

  Scenario: Update a given's task's progress
    Given I am on the view task page for "Hello, world!"
    When I check "is_done" for "Write a makefile"
    And I press "Update" for "Write a makefile"
    Then I should be on the view task page for "Hello, world!"
    And I should see "60% Complete"
    And the value of "progress" should be "0.60"

