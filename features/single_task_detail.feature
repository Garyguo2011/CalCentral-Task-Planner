Feature: Show details of One Task
 
  As student in Berkeley
  So that I can view detail remaining time, open questions of one task
  I want to click a task title and show the detail page of a single task

Background: tasks have been added to database

  Given the following users exist:
  | first_name | last_name | email                 | password  | 
  | Xinran     | Guo       | 123454321@hotmail.com | 123454321 |
  | Xu         | He        | 123@hotmail.com       | 123454321 |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | user_id |
  | HW1       | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 6/Mar/2015 23:59:00 -0800  | New      | 1       |
  | PROJ1     | CS188  | Project  | 3/Mar/2015 23:59:00 -0800  | 16/Mar/2015 23:59:00 -0800 | New      | 1       |

  Given the following subtasks exist:
  | description      | is_done | task_id |
  | Checkout Website | true    | 1       |
  | Bring Calculator | false   | 2       |

Scenario: General details of a task
  When I sign in as Xinran
  Then I should on the home page.
  When I press "PROJ1"
  Then I should on "Detail" page of "PORJ1"
  Then I should see the following "PROJ1", "CS188", "Project", "March 03, 2015", "March 16, 2015", "New"
  Then I should see "Checkout Website"
  Then I should not see "Bring Calculator"

Scenario: Users can not visit the other users page
  When I login "123454321@hotmail.com" with "123454321"
  Then I should on the home page.
  Given I am on the 
  Then I should see "Checkout Website"
  Then I should not see "Bring Calculator"

  When I am on the home page.
  Then I press "Project1"
  Then I should see 2 remaining questions and 3 total questions
  Then I should see "Open questions progress bar" with 67%

Scenario: Remaining Time
  When I login "123454321@hotmail.com" with "123454321"

  When I am on the home page.
  Then I press "Project1"
  And the current time is 2015-03-01 8:00am PDT
  Then I should see the remaining time is "5 Days Left"
