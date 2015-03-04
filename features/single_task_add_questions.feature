Feature: Open Questions associate with a Task
   
  As student in Berkeley
  So that I can view my remaining questions of a tasks
  I want to add open questions associate with my assignment

Background: tasks have been added to database

 Given the following movies exist:
  | title    | course |     due                  |   status  |     owner     |
  | Project1 | cs164  |  2015-03-03 11:59pm PDT  |     NEW   |   Xinran Guo  |
  | Midterm1 | cs186  |  2015-03-05 11:59pm PDT  |     NEW   |   Xinran Guo  |

 Given the following open question in "Midterm1":
  |   Time             | problem description            | solution     |  Status  |
  | 2015-03-02 01:30PM | How do we handle indentation?  | NOT RESOLVE  |  OPEN    | 

Scenario: Add a new quesiton
  Given I am on the detail page for "Project1"
  And I press "ADD" button
  Then I should in "New Question" page
  Then I fill "description" with "Fix bugs on lexer"
  When I press "save"
  Then I should on the detail page for "Project1"
  Then I should see the "Fix bugs on lexer" in "open question" area

Scenario: Add a question resolution
  Given I am on the detail page for "Midterm1"
  And I press "Fix" button of "How do we handle indentation?"
  Then I should in "Edit Question" page
  When I fill "solution" field with "use default handling"
  Then I press "save" button
  Then I should on the detail page for "Midterm1"
  Then I should see "use default handling" in "solution" field.