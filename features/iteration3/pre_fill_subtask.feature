feature: Pre fill some subtasks
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
  When I select "3" from "Rate"
  When I select "New" from "status"
  And I select "Project" from "kind"
  And I press "Create Task"
  Then I should be on detailed page for "Project 1"
  And I should see "plan" with scope of "subtasks"
  And I should see  "design" with scope of "subtasks"
  And I should see "code" with scope of "subtasks"
  And I should see "test" with scope of "subtasks"

Scenario: Create a paper should have brain storm, draft, revision subtasks
	When I follow "Add new task"
  Then I should currently on the new_task page
  When I fill in "Title" with "Essay 1"
  When I fill in "task_due" with "2015-04-15 20:25: -07:00"
  When I select "Computer Science 195" from "Course"
  When I fill in "task_release" with "2015-03-02 20:25: -07:00"
  When I select "3" from "Rate"
  When I select "New" from "status"
  And I select "Paper" from "kind"
  And I press "Create Task"
  Then I should be on detailed page for "Project 1"
  And I should see "brain storm" with scope of "subtasks"
  And I should see  "draft" with scope of "subtasks"
  And I should see "revision" with scope of "subtasks"


Scenario: Create an exam should have review notes, review homework, practice exam subtasks
	When I follow "Add new task"
  Then I should currently on the new_task page
  When I fill in "Title" with "Midterm 1"
  When I fill in "task_due" with "2015-04-20 20:25: -07:00"
  When I select "Computer Science 169" from "Course"
  When I fill in "task_release" with "2015-03-20 20:25: -07:00"
  When I select "3" from "Rate"
  When I select "New" from "status"
  And I select "Exam" from "kind"
  And I press "Create Task"
  Then I should be on detailed page for "Project 1"
  And I should see "review notes" with scope of "subtasks"
  And I should see  "review homework" with scope of "subtasks"
  And I should see "practice exam" with scope of "subtasks"


Scenario: Create a homework should ask me number of questions to set subtasks
	When I follow "Add new task"
  Then I should currently on the new_task page
  And I should not see "Please specify the number of questions in this homework"
  When I fill in "Title" with "HW1"
  When I fill in "task_due" with "2015-04-20 20:25: -07:00"
  When I select "Computer Science 169" from "Course"
  When I fill in "task_release" with "2015-03-20 20:25: -07:00"
  When I select "3" from "Rate"
  When I select "New" from "status"
  And I select "HW" from "kind"
  Then I should see "Please specify the number of questions in this homework"
  When I select "2" from "questions"
  And I press "Create Task"
  Then I should be on detailed page for "Project 1"
  And I should see "Question 1" with scope of "subtasks"
  And I should see  "Question 2" with scope of "subtasks"

