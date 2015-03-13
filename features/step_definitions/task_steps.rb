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

Given /I sign in "(.*)" with "(.*)"/ do |email, password|
  fill_in("Email", :with => email)
  fill_in("user_password", :with => password)
  click_button("Log in")
end

When /I select (.*) to filter/ do |field|
  # puts(page.html)
  within '#MySelect' do
    click_link(find("option[value='/tasks?filter=#{field}']"))
  end
  puts(page.html)
end


Then /I should not see the following tasks:(.*)/ do |task_list|
  task_list.split(',').each do |task|
    steps %Q{
      Then I should not see #{task}
    }
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  elem = page.html
  assert(elem.index(e1) < elem.index(e2), "incorrect order, #{e1} should be before #{e2}")
end 

Then /I should see all the tasks/ do
  # Make sure that all the tasks in the app are visible in the table
  tasks = Task.find(:all)
  if tasks.size == 5
    tasks.each do |task|
      assert(page.body =~ /#{task[:title]}/m, "#{task[:title]} not appear in the list")
    end
  else
    return false
  end
end

Then /I should (not )?see the following (.*)/ do |is_not, content|
  content.delete('"').split(',').each do |text|
    if is_not
      if page.respond_to? :should
        page.should_not have_content(text)
      else
        assert !page.has_content?(text)
      end
    else
      if page.respond_to? :should
        page.should have_content(text)
      else
        assert page.has_content?(text)
      end
    end
  end
end

Then /I should (not )?see the following (.*) in form field/ do |is_not, content|
  content.delete('"').split(',').each do |text|
    if is_not
      if page.respond_to? :should
        page.should_not have_content(text)
      else
        assert !page.has_content?(text)
      end
    else
      if page.respond_to? :should
        page.should have_content(text)
      else
        assert page.has_content?(text)
      end
    end
  end
end

Then /^I should (not )?see "(.*?)" in Subtask$/ do |is_not, content|
  subtask_position = page.body.index("Subtasks")
  # puts page.body.index(content)
  # puts page.body
  # puts Task.all
  content_position = page.body.index(content) ? page.body.index(content) : -1
  if is_not
    assert(content_position == -1)
  else
    assert(subtask_position < content_position && content_position != -1, "Error")
  end
end
