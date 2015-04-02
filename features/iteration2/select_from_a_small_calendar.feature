Feature: Select from a small calendar to create/ update Task release/due date
As student in Berkeley [Jinge, Hao]
So that i can select my task date from date form
I want to directly select from a visual Calendar

Background: users and tasks have been added to database
  
  Given the following users exist:
  | first_name | last_name | email                   | password  | 
  | Jinge      | Zhang     | zhangjinge588@gmail.com | 12345678  |
  | Rod        | Zhang     | zhangjinge0110@126.com  | 12345678  |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | rate | user_id |
  | HW1       | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 6/Mar/2015 23:59:00 -0800  | New      |   1  | 1       |
  | PROJ1     | CS169  | Project  | 9/Mar/2015 23:59:00 -0800  | 16/Mar/2015 23:59:00 -0800 | New      |   2  | 1       |
  | ESSAY1    | CS195  | Paper    | 9/Mar/2015 23:59:00 -0800  | 31/Mar/2015 23:59:00 -0800 | Started  |   3  | 1       |
  | HW2       | CS186  | Homework | 27/Feb/2015 23:59:00 -0800 | 2/Mar/2015 23:59:00 -0800  | Started  |   4  | 2       |
  | MIDTERM1  | CS164  | Exam     | 1/Mar/2015 12:00:00 -8000  | 1/Apr/2015 16:00:00 -0800  | Finished |   5  | 2       |
<<<<<<< HEAD

  And I am on the sign-in page
  Given I sign in "zhangjinge588@gmail.com" with "12345678"                             
  Given I am currently on the new_task page  


Scenario: show Calendar form 
                                
Then I click the icon "calendar_icon_release" 


Scenario: sad Calendar form path  

When I fill in "task_release" with "2015-03-29 10:40: -07:00" 
When I fill in "task_due" with "2015-03-28 20:25: -07:00" 
When I fill in "Title" with "CS169 HW"                        
When I select "New" from "Status"                             
When I select "Homework" from "Kind"                          
When I select "Computer Science 169" from "Course"    
When I select "3" from "Rate" 
And I press "Create Task" 
Then I should see "Due date must be after the Release date!"



=======
  
Scenario: show Calendar form
  And I am on the sign-in page
  Given I sign in "zhangjinge588@gmail.com" with "12345678"                             
  Given I am currently on the new_task page                          
  Then I click the icon "calendar_icon_release" with "release_date"
  Then I should see calendar datetime picker
>>>>>>> d01019431a80512bd35ee87a6487d3890b1f9945
