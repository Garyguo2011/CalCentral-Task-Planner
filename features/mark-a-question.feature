Feature: search for movies by director
 
  As a student in Berkeley
  So that I can keep track of all my open questions for a task
  I want to mark a question as open or resolved
 
Background: tasks in CalCentral database and questions in iBearHost database
 
  Given the following tasks exist:
  | task               | due_date   | notes         | status      |
  | Econ Exam #1       | 2015-02-24 | 155 Dwinelle  | Completed   |
  | SaaS Homework #5   | 2015-03-08 |               | Scheduled   | 
  | SaaS Checkpoint #1 | 2015-03-04 |               | Scheduled   |
  | SaaS Micro-Quiz    | 2015-03-05 | Online quiz   | Unscheduled |

  And given the following questions exist:
  | question                      | task_id | response              | status   |
  | Where is the exam room?       | 1       | 155 Dwinelle          | Resolved |
  | How do I take the micro-quiz? | 4       |                       | Open     |
  | How do I do Checkpoint #1?    | 3       | Complete iteration #1 | Resolved |

Scenario: mark question as open
  When I go to the edit page for "How do I do Checkpoint #1?"
  And  I select "Open"
  And  I press "Update Question"
  Then the status of "How do I do Checkpoint #1?" should be "Open"
 
Scenario: mark question as resolved
  When I go to the edit page for "How do I take the micro-quiz?"
  And  I select "Resolved"
  And  I press "Update Question"
  Then the status of "How do I take the micro-quiz?" should be "Resolved"

