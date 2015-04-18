Feature: Task Email Notification

  As student in Berkeley
  In order not to forget to do a task when i didn’t check CalCentral
  I want to an Email notification that summary my current tasks due in this week.

Background: users and tasks have been added to database
  
  Given it is currently Apr,6 2015

  Given the following users exist:
  | first_name | last_name | email                   | password  | email_notifications |
  | Xinran     | Guo       | xinran@gmail.com        | 111111111 | daily               |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | rate  | user_id |
  | Typo-blog | CS169  | Homework | 3/Apr/2015 23:59:00 -0800  | 8/Apr/2015 23:59:00 -0800  | New      | 1     | 1       |
  | Homework6 | CS164  | Homework | 4/Apr/2015 23:59:00 -0800  | 9/Apr/2015 23:59:00 -0800  | Past Due | 5     | 1       |
  | Proj3     | CS186  | Project  | 1/Apr/2015 23:59:00 -0800  | 10/Apr/2015 23:59:00 -0800 | Started  | 3     | 1       |
  | Quiz9     | CS164  | Exam     | 1/Apr/2015 23:59:00 -0800  | 20/Apr/2015 23:59:00 -0800 | New      | 5     | 1       |
  | Essay2    | CS164  | Paper    | 1/Apr/2015 23:59:00 -0800  | 20/Apr/2015 23:59:00 -0800 | Finished | 5     | 1       |
  
  And I am on the sign-in page
  Given I sign in "xinran@gmail.com" with "111111111"
  Then I should be on the homepage
  
Scenario: User can change Email configuartion from Edit profile page
  Given it is currently Apr,5 2015
  When I follow "Edit Profile"
  Then I select "hourly" from "Email notifications"
  When I fill in "Current password" with "111111111"
  Then I press "Update"
  When I follow "Edit Profile"
  Then I should see "hourly" in page
  Then I should receive a notification email

Scenario: User should receive Email when create a task
  When I follow "Add new task"
  Then I should currently on the new_task page
  When I fill in "task_due" with "2015-03-30 20:25: -07:00"
  When I select "Computer Science 169" from "Course"
  When I fill in "task_release" with "2015-03-29 20:25: -07:00"
  When I select "3" from "Rate"
  And I press "Create Task"
  Then I should receive a notification email

Scenario: User should receive Email when update a task
  Given I am on the tasks page
  When I follow "Quiz9"
  When I press "Edit Task"
  When I select "3" from "Rate"
  And I press "Update Task"
  Then I should receive a notification email




