# Add a declarative step here for populating the DB with tasks.

Given /the following (.*) exist/ do |which, table|
  table.hashes.each do |elem|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    if which == "users"
      User.create!(elem)
    elsif which == "tasks"
      Task.create!(elem)
    else
      Subtask.create!(elem)
    end
  end
end


Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  elem = page.html
  assert(elem.index(e1) < elem.index(e2), "incorrect order, #{e1} should be before #{e2}")
end


When /I (un)?check the following courses: (.*)/ do |uncheck, course_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end


Then /I should see all the tasks/ do
  # Make sure that all the tasks in the app are visible in the table
  tasks = Task.find(:all)
  if tasks.size == 6
    tasks.each do |task|
      assert(page.body =~ /#{movie[:title]}/m, "#{task[:title]} not appear in the list")
    end
  else
    return false
  end
end
