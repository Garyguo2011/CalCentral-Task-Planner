Feature: search for movies by director
 
  As a student in Berkeley
  So that I can view my remaining questions for tasks
  I want to add open questions associated with my assignment
 
Background: tasks in CalCentral database and questions in iBearHost database
 
  Given the following tasks exist:
  | task               | due_date   | notes         | status      |
  | Econ Exam #1       | 2015-02-24 | 155 Dwinelle  | Completed   |
  | SaaS Homework #5   | 2015-03-08 |               | Scheduled   | 
  | SaaS Checkpoint #1 | 2015-03-04 |               | Scheduled   |
  | SaaS Micro-Quiz    | 2015-03-05 | Online quiz   | Unscheduled |

  And given the following questions exist:
  | question                      | task_id | response              | status   |
  | Exam notes?                   | 1       | No                    | Resolved |
  | How do I take the micro-quiz? | 4       |                       | Open     |
  | How do I do Checkpoint #1?    | 3       | Complete iteration #1 | Resolved |
  | Calculator allowed?           | 1       |                       | Open     |

Scenario: show task questions for Econ Exam #1
  When I go to the show task questions page for "Econ Exam #1"
  Then I should see "Exam notes?"
  And the status should be marked as "Resolved"

Scenario: show task questions for Econ Exam #1
  When I go to the show task questions page for "Econ Exam #1"
  Then I should see "Calculator allowed?"
  And the status should be marked as "Open"


