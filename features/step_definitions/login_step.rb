Given /^I am currently on the ([^"]*) page$/ do |path|
	visit path_to(path)
end
Given /^I should currently on the ([^"]*) page$/ do |path|
	visit path_to(path)
end
