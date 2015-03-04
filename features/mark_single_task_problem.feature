Feature: Mark a question Open/Resolved
 
  As student in Berkeley
  So that I can keep track of all my open questions for a tasks
  I want to mark a question as open or resolved and add solutions

Background: tasks have been added to database

  Given the following movies exist:
  | title    | course |     due                  |   status  |     owner     |
  | Project1 | cs164  |  2015-03-05 11:59pm PDT  |     NEW   |   Xinran Guo  |

  Given the following open question in "Project1":
  |   Time             | problem description            | solution               |  Status  |
  | 2015-03-02 01:30PM | How do we handle indentation?  | Create lexer to handle |  OPEN    | 
  | 2015-03-01 01:30PM | How do we handle Fucntion_def? | NOT RESOLVE            |  OPEN    | 
  | 2015-02-28 01:30PM | How do we handle If-statement? | Follow Python Grammer2 |  RESOLVE | 

Scenario: Mark a quesiton as resolve
  Given I am on the deails page for "Project1"
  And I press "Resolve" button of "How do we handle indentation?"
  Then "How do we handle indentation?" should in "close question" area

Scenario: Mark a question as Reopen
  Given I am on the deails page for "Project1"
  And I press "Reopen" button of "How do we handle If-statement?"
  Then "How do we handle If-statement?" shoud in "open question" area


