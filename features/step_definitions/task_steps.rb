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

Then /I should see "(.*)" before "(.*)"$/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  elem = page.html
  assert(elem.index(e1) < elem.index(e2), "incorrect order, #{e1} should be before #{e2}")
end 

Then /I should see all the tasks/ do
  # Make sure that all the tasks in the app are visible in the table
  tasks = Task.find(:all)
  assert tasks.size == 5
  tasks.each do |task|
    assert(page.body =~ /#{task[:title]}/m, "#{task[:title]} not appear in the list")
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
  content_position = page.body.index(content) ? page.body.index(content) : -1
  if is_not
    assert(content_position == -1)
  else
    assert(subtask_position < content_position && content_position != -1, "Error")
  end
end

Then /^I press "(.*?)" for "(.*?)"/ do |button, subtask_title|
  subtask = Subtask.find_by_description(subtask_title)
  css_class = "#subtask_#{subtask.id}"
  within(css_class) do
    click_on(button)
  end
end

When /^(?:|I )(un)?check "(.*?)" done$/ do |uncheck, subtask_title|
  subtask = Subtask.find_by_description(subtask_title)
  css_class = "#subtask_#{subtask.id}"
  within(css_class) do
    if uncheck
      uncheck("subtask_is_done")
    else
      check("subtask_is_done")
    end
  end
end

Then /^I should (not )?see the done checkbox checked for "(.*)"$/ do |is_not, subtask_title|
  subtask = Subtask.find_by_description(subtask_title)
  css_class = "#subtask_#{subtask.id}"
  within(css_class) do
    done_box = find('#subtask_is_done')
    if is_not.nil?
      assert (done_box[:checked] == true)
    else
      assert (done_box[:checked] == false)
    end 
  end
end

When /^I (change|add) description for "(.*?)" to "(.*?)"$/ do |action, subtask_title, content|
  if action == "change"
    subtask = Subtask.find_by_description(subtask_title)
    css_class = "#subtask_#{subtask.id}"
    within (css_class) do
      # puts find("#subtask_description")[:value]
      fill_in("subtask[description]", :with => content)
      # puts find("#subtask_description")[:value]
      # click_on("Update")
      # puts find("#subtask_description")[:value]
    end
  else
    within ('#subtask_new') do
      fill_in("subtask[description]", :with => content)
      # puts page.body
    end
  end
end


Then /^I click the icon "(.*?)" with "(.*?)"$/ do |icon_id, class_id|
  find("##{icon_id}").click
end 

Then /^I should see calendar datetime picker$/ do
  index = page.body.index("bootstrap-datetimepicker-widget")
  assert(index != -1)
end

Then /^I should (not )?see "(.*)" with the scope of "(.*)"$/ do |is_not, content, css_id|
  within("##{css_id}") do
    if is_not == "not"
      assert(page.body.index(content) == -1)
    else
      assert(page.body.index(content) != -1)
    end
  end
end


Then /I can see "(.*)" before "(.*)" with the scope of "(.*)"$/ do |e1, e2, legend_id|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  within("##{legend_id}") do
    elem = page.html
    assert(elem.index(e1) < elem.index(e2), "incorrect order, #{e1} should be before #{e2}")
  end
end 

# Then /^the done checkbox for "(.*)" should be checked$/ do |subtask_title|
#   subtask = Subtask.find_by_description(subtask_title)
#   css_class = "#subtask_#{subtask.id}"
#   # puts subtask_title
#   # puts Subtask.find_by_description(subtask_title).is_done
#   within(css_class) do
#     field_checked = find_field('subtask_is_done')['checked']
#     if field_checked.respond_to? :should
#       field_checked.should be_true
#     else
#       assert field_checked
#     end
#   end
# end
