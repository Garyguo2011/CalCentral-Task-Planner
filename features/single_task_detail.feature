Feature: Show details of One Task
 
  As student in Berkeley
  So that I can view detail remaining time, open questions of one task
  I want to click a task title and show the detail page of a single task

Background: tasks have been added to database

  Given the following movies exist:
  | title    | course |     due              | status  |     owner     |
  | Project1 | cs164  |  2015-03-05 11:59pm  |   NEW   |   Xinran Guo  |
  | Vatamin1 | cs186  |  2015-03-15 11:59pm  |   NEW   |   Xinran Guo  |
  | Quiz1    | cs169  |  2015-04-07 11:59pm  |   NEW   |   Xinran Guo  |

  Given the following open question in "Project1":
  |   Time             | problem description            | solution               |  Status  |
  | 2015-03-02 01:30PM | How do we handle indentation?  | Create lexer to handle |  OPEN    | 
  | 2015-03-01 01:30PM | How do we handle Fucntion_def? | NOT RESOLVE            |  OPEN    | 
  | 2015-02-28 01:30PM | How do we handle If-statement? | Follow Python Grammer2 |  RESOLVE | 

Scenario: Show details of a task
  When I am on the home page.
  Then I press "Project1"
  Then I should see "How do we handle indentation?" in "open question" area
  Then I should see "How do we handle If-statement?" in "close question" area

Scenario: Open question progress
  When I am on the home page.
  Then I press "Project1"
  Then I should see 2 remaining questions and 3 total questions
  Then I should see "Open questions progress bar" with 67%

Scenario: Remaining Time
  When I am on the home page.
  Then I press "Project1"
  And the current time is 2015-03-01 8:00am PDT
  Then I should see the remaining time is "5 Days Left"
