Feature: Pre fill some subtasks
As student in Berkeley
So that I don't have to input too much information when create a task
I want to have some subtask prefilled base on task type

Background: users have been added to database
  
  Given it is currently Apr,1 2015
  
  Given the following users exist:
  | first_name | last_name | email                 | password  | 
  | Xu         | He        | 123454321@hotmail.com | 123454321 |

  And I am on the sign-in page
  And I sign in "123454321@hotmail.com" with "123454321"


Scenario: Create a project should have plan, design, code and test subtasks
	When I follow "Add new task"
  Then I should currently on the new_task page
  When I fill in "Title" with "Project 1"
  When I fill in "task_due" with "2015-04-30 20:25: -07:00"
  When I select "Computer Science 169" from "Course"
  When I fill in "task_release" with "2015-03-29 20:25: -07:00"
  And I select "Project" from "Kind"
  And I select "3" from "Rate"
  And I select "New" from "Status"
  And I select "Yes" from "Prefill?"
  And I press "Create Task"
  Then I should be on the detail page for "Project 1"
  Then I should see "Finish plan" in Subtask
  And I should see "Finish design" in Subtask
  And I should see "Finish code" in Subtask
  And I should see "Finish unit test" in Subtask
  And I should see "Finish integration test" in Subtask

Scenario: Create a paper should have brain storm, draft, revision subtasks
	When I follow "Add new task"
  Then I should currently on the new_task page
  When I fill in "Title" with "Essay 1"
  When I fill in "task_due" with "2015-04-15 20:25: -07:00"
  When I select "Computer Science 195" from "Course"
  When I fill in "task_release" with "2015-03-02 20:25: -07:00"
  When I select "3" from "Rate"
  When I select "New" from "Status"
  And I select "Paper" from "Kind"
  And I select "Yes" from "Prefill?"
  And I press "Create Task"
  Then I should be on the detail page for "Essay 1"
  And I should see "Finish brain storm" in Subtask
  And I should see "Finish draft" in Subtask
  And I should see "Finish revision" in Subtask
  And I should see "Finish peer review" in Subtask


Scenario: Create an exam should have review notes, review homework, practice exam subtasks
	When I follow "Add new task"
  Then I should currently on the new_task page
  When I fill in "Title" with "Midterm 1"
  When I fill in "task_due" with "2015-04-20 20:25: -07:00"
  When I select "Computer Science 169" from "Course"
  When I fill in "task_release" with "2015-03-20 20:25: -07:00"
  When I select "3" from "Rate"
  When I select "New" from "Status"
  And I select "Exam" from "Kind"
  And I select "Yes" from "Prefill?"
  And I press "Create Task"
  Then I should be on the detail page for "Midterm 1"
  And I should see "Finish note review" in Subtask
  And I should see "Finish homework review" in Subtask    
  And I should see "Finish practice exam" in Subtask


Scenario: Create an other assignment should give trivial subtask
  When I follow "Add new task"
  Then I should currently on the new_task page
  When I fill in "Title" with "??"
  When I fill in "task_due" with "2015-04-20 20:25: -07:00"
  When I select "Computer Science 169" from "Course"
  When I fill in "task_release" with "2015-03-20 20:25: -07:00"
  When I select "3" from "Rate"
  When I select "New" from "Status"
  And I select "Other" from "Kind"
  And I select "Yes" from "Prefill?"
  And I press "Create Task"
  Then I should be on the detail page for "??"    
  And I should see "trivial" in Subtask  
