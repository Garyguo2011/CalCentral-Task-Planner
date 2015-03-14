Feature: Mark a Subtask Open/Resolved
 
  As student in Berkeley
  So that I can keep track of all my open questions for a tasks
  I want to mark a subtask as open or resolved and add solutions

Background: tasks have been added to database

  Given the following users exist:
  | first_name | last_name | email            | password  | 
  | Xinran     | Guo       | xinran@gmail.com | 111111111 |
  | Xu         | He        | xu@ibearHost.com | 111111111 |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | user_id |
  | HW1       | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 6/Mar/2015 23:59:00 -0800  | New      | 1       |
  | PROJ1     | CS188  | Project  | 3/Mar/2015 23:59:00 -0800  | 16/Mar/2015 23:59:00 -0800 | New      | 1       |
  | XU-hw3    | CS188  | Quiz     | 3/Mar/2015 23:59:00 -0800  | 16/Mar/2015 23:59:00 -0800 | New      | 2       |

  Given the following subtasks exist:
  | description      | is_done | task_id |
  | Checkout Website | true    | 1       |
  | Bring Calculator | false   | 2       |
  | Go to OfficeHour | true    | 2       |
  | Google Answer    | false   | 2       |

  And I am on the sign-in page
  Given I sign in "xinran@gmail.com" with "111111111"
  Given I am on the detail page for "PROJ1"

Scenario: Delete a task
  Then I should see "Google Answer" in Subtask
  When I press "Delete" for "Google Answer"
  Then I should not see "Google Answer" in Subtask

Scenario: Mark a subtask done
  When I check "Bring Calculator" done
  Then I press "Update" for "Bring Calculator"
  Then I should see the done checkbox checked for "Bring Calculator"
  When I go to the detail page for "PROJ1"
  Then I should see the done checkbox checked for "Bring Calculator"

Scenario: Unmark a subtask done
  When I uncheck "Go to OfficeHour" done
  Then I press "Update" for "Go to OfficeHour"
  When I go to the detail page for "PROJ1"
  Then I should not see the done checkbox checked for "Go to OfficeHour"

Scenario: Change description of subtask, and edit a subtask
  Then I should see "Bring Calculator" in Subtask
  When I change description for "Bring Calculator" to "Bring TI-89 Calculator"
  Then I press "Update" for "Bring Calculator"
  Then I should not see "Bring  Calculator" in Subtask

Scenario: Add description of subtask, and create a new subtask
  Then I should see "Go to OfficeHour" in Subtask
  When I add description for "New Subtask" to "Go to OfficeHour"
  Then I press "Create"
  Then I should see "Go to OfficeHour" in Subtask
