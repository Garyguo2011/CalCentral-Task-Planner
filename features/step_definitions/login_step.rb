Given /^I am currently on ([^"]*)$/ do |path|
	visit path_to(path)
end

Given /^I should currently on ([^"]*)$/ do |path|
	visit path_to(path)
end

Then /^I would see "([^"]*)" in my "([^"]*)"$/ do |content, field|
	assert page.has_field?(field, :with => content)
end
