# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the sign-in page/ then '/users/sign_in'
    when /^the (Task Planner )?home\s?page$/ then '/'
    when /^the tasks page$/ then '/tasks'
    when /^new_task$/ then '/users/tasks/new'
    when /^Project filter page/ then '/tasks?filter=Project'
    when /^Show All page/ then 'tasks?filter=Show%20All'
    when /^add new task/ then '/tasks/new'

    when /^the detail page for "([^"]*)"$/i
     task_path(Task.find_by_title($1))
    when /^the edit page for "([^"]*)"$/i
     edit_task_path(Task.find_by_title($1))
    when /^the subtask index page for "([^"]*)"$/i
     task_subtasks_path(Task.find_by_title($1))
    when /^the subtask new page for "([^"]*)"$/i
     new_task_subtask_path(Task.find_by_title($1))
    when /^the subtask edit page for "([^"]*)"$/i
     edit_task_subtask_path(Subtask.find_by_description($1).task, Subtask.find_by_description($1))
    when /^the subtask show page for "([^"]*)"$/i
     task_subtask_path(Subtask.find_by_description($1).task, Subtask.find_by_description($1))

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
