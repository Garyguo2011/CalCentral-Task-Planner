Given /^I am currently on ([^"]*)$/ do |path|
	visit path_to(path)
end

Given /^I should currently on ([^"]*)$/ do |path|
	visit path_to(path)
end
