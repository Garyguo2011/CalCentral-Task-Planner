Feature: Timeline “show more” option
 
As staff in CalCentral
So that I can keep dashboard view clean
I want to at most show 5 tasks in list with a “show more” option that expand list to complete


Background: users and tasks have been added to database
  
  Given it is currently Mar,31 2015
  
  Given the following users exist:
  | first_name | last_name | email                 | password  | 
  | Xu         | He        | 123454321@hotmail.com | 123454321 |

  Given the following tasks exist:
  | title | course | kind     | release                    | due                        | status   | user_id | rate |
  | HW1   | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 1/Apr/2015 23:59:00 -0800  | New      | 1       | 1    |
  | HW2   | CS169  | Project  | 9/Mar/2015 23:59:00 -0800  | 2/Apr/2015 23:59:00 -0800  | New      | 1       | 1    |
  | HW3   | CS164  | Exam     | 1/Mar/2015 12:00:00 -8000  | 3/Apr/2015 16:00:00 -0800  | Started  | 1       | 1    |
  | HW4   | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 4/Apr/2015 23:59:00 -0800  | New      | 1       | 1    |
  | HW5   | CS169  | Project  | 9/Mar/2015 23:59:00 -0800  | 5/Apr/2015 23:59:00 -0800  | New      | 1       | 1    |
  | HW6   | CS164  | Exam     | 1/Mar/2015 12:00:00 -8000  | 6/Apr/2015 16:00:00 -0800  | Started  | 1       | 1    |
  | HW7   | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 7/Apr/2015 23:59:00 -0800  | New      | 1       | 1    |
  | HW8   | CS169  | Project  | 9/Mar/2015 23:59:00 -0800  | 8/Apr/2015 23:59:00 -0800  | New      | 1       | 1    |
  | HW9   | CS164  | Exam     | 1/Mar/2015 12:00:00 -8000  | 9/Apr/2015 16:00:00 -0800  | Started  | 1       | 1    |
  | HW10  | CS169  | Homework | 4/Mar/2015 23:59:00 -0800  | 10/Apr/2015 23:59:00 -0800 | New      | 1       | 1    |
  | HW11  | CS169  | Project  | 9/Mar/2015 23:59:00 -0800  | 11/Apr/2015 23:59:00 -0800 | New      | 1       | 1    |
  | HW12  | CS164  | Exam     | 1/Mar/2015 12:00:00 -8000  | 12/Apr/2015 16:00:00 -0800 | Started  | 1       | 1    |

  And I am on the sign-in page
  And I sign in "123454321@hotmail.com" with "123454321"
  Given I am currently on the tasks page

Scenario: all the unifinished past due tasks should automatically change status
  Then I should see "HW1" with the scope of "Timeline"
  And I should see "HW2" with the scope of "Timeline"
  And I should see "HW3" with the scope of "Timeline"
  And I should see "HW4" with the scope of "Timeline"
  And I should see "HW5" with the scope of "Timeline"
  And I should see "HW6" with the scope of "Timeline"
  And I should see "Load More" with the scope of "Timeline"
  When I follow "load-more"
  Then I should see "HW6" with the scope of "Timeline"
  And I should not see "HW10" with the scope of "Timeline"
  And I should not see "HW11" with the scope of "Timeline"
  When I follow "load-more"
  Then I should see "HW12" with the scope of "Timeline"