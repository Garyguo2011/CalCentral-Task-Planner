[Feature] Select from a small calendar to create/ update Task release/due date
As student in Berkeley [Jinge, Hao]
So that i can select my task date from date form
I want to directly select from a visual Calendar

Background: users and tasks have been added to database
  
  Given the following users exist:
  | first_name | last_name | email                   | password  | 
  | Jinge      | Zhang     | zhangjinge588@gmail.com | 12345678  |
  | Rod        | Zhang     | zhangjinge0110@126.com  | 12345678  |

  Given the following tasks exist:
  | title     | course | kind     | release                    | due                        | status   | user_id |
  | HW1       | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 6/Mar/2015 23:59:00 -0800  | New      | 1       |
  | PROJ1     | CS169  | Project  | 9/Mar/2015 23:59:00 -0800  | 16/Mar/2015 23:59:00 -0800 | New      | 1       |
  | ESSAY1    | CS195  | Paper    | 9/Mar/2015 23:59:00 -0800  | 31/Mar/2015 23:59:00 -0800 | Started  | 1       |
  | HW2       | CS186  | Homework | 27/Feb/2015 23:59:00 -0800 | 2/Mar/2015 23:59:00 -0800  | Started  | 2       |
  | MIDTERM1  | CS164  | Exam     | 1/Mar/2015 12:00:00 -8000  | 1/Apr/2015 16:00:00 -0800  | Finished | 2       |

scenario: show Calendar form 
Given I am in the task page 
When I press “Select Start Date” 
Then I should see the “Calendar” 
When I select “03/21/2015” 
Then I should see “03/21/2015” as a Start Date field
When I press “Select Due Date”
And I select “03/23/2015”  
Then I should see “03/23/2015” as Due Date field 


scenario: sad Calendar form path  
Given I am in the task page
Given the current date is “03/17/2015” 
Then I should not see “03/16/2015”
When I press “Select Start Date” 
When I select “03/21/2015” 
When I press “Select Due Date 
Then I should not see “03/20/2015” 