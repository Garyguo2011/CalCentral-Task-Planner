Feature: Show details of One Task
 
  As student in Berkeley
  So that I can view detail remaining time, open questions of one task
  I want to click a task title and show the detail page of a single task

Background: tasks have been added to database

  Given the following users exist:
  | first_name | last_name | email            | password  | 
  | Xinran     | Guo       | xinran@gmail.com | 111111111 |
  | Xu         | He        | xu@ibearHost.com | 111111111 |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | rate | user_id |
  | HW1       | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 6/Mar/2015 23:59:00 -0800  | New      | 1    | 1       |
  | PROJ1     | CS188  | Project  | 3/Mar/2015 23:59:00 -0800  | 16/Mar/2015 23:59:00 -0800 | New      | 2    | 1       |
  | XU-hw3    | CS188  | Quiz     | 3/Mar/2015 23:59:00 -0800  | 16/Mar/2015 23:59:00 -0800 | New      | 3    | 2       |

  Given the following subtasks exist:
  | description      | is_done | task_id |
  | Checkout Website | true    | 1       |
  | Bring Calculator | false   | 2       |
  | Bring Pencil     | false   | 2       |

  And I am on the sign-in page

Scenario: General details of a task
  Given I sign in "xinran@gmail.com" with "111111111"
  Then I should be on the homepage
  When I follow "PROJ1"
  Then I should be on the detail page for "PROJ1"
  Then I should see the following "PROJ1", "CS188", "Project", "Mar 03", "Mar 17"
  Then I should see "Bring Calculator" in Subtask
  Then I should not see "Checkout Website" in Subtask

Scenario: Users can not visit the other users task detail page
  When I sign in "xu@ibearHost.com" with "111111111"
  When I go to the detail page for "PROJ1"
  Then I should be on the homepage
  When I go to the edit page for "PROJ1"
  Then I should be on the homepage
  Then I should see "XU-hw3"
  Then I should not see "PROJ1"

Scenario: Users should vist some detail subtask page
  Given I sign in "xinran@gmail.com" with "111111111"
  When I go to the subtask new page for "PROJ1"
  Then I should be on the subtask new page for "PROJ1"
  When I go to the subtask index page for "PROJ1"
  Then I should be on the subtask index page for "PROJ1"
  When I go to the subtask edit page for "Bring Calculator"
  Then I should be on the subtask edit page for "Bring Calculator"
  When I go to the subtask show page for "Bring Pencil"
  Then I should be on the subtask show page for "Bring Pencil"
