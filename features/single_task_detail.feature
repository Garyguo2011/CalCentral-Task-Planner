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
  | title     | course | kind     | release                    | due                        | status   | user_id |
  | HW1       | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 6/Mar/2015 23:59:00 -0800  | New      | 1       |
  | PROJ1     | CS188  | Project  | 3/Mar/2015 23:59:00 -0800  | 16/Mar/2015 23:59:00 -0800 | New      | 1       |
  | XU-hw3    | CS188  | Quiz     | 3/Mar/2015 23:59:00 -0800  | 16/Mar/2015 23:59:00 -0800 | New      | 2       |

  Given the following subtasks exist:
  | description      | is_done | task_id |
  | Checkout Website | true    | 1       |
  | Bring Calculator | false   | 2       |

Scenario: General details of a task
  When I sign in as "xinran@gmail.com" with "111111111"
  Then I should on the home page.
  When I press "PROJ1"
  Then I should on "Detail" page of "PORJ1"
  Then I should see the following "PROJ1", "CS188", "Project", "March 03, 2015", "March 16, 2015", "New"
  Then I should see "Checkout Website"
  Then I should not see "Bring Calculator"

Scenario: Users can not visit the other users task detail page
  When I sign in as "xu@ibearHost.com" with "111111111"
  When I visit "Detail" page of "PORJ1"
  Then I should on the home page
  Then I should see "XU-hw3"
  Then I should not "PROJ1"
