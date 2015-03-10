require 'spec_helper'

describe "tasks/edit" do
  before(:each) do
    @task = assign(:task, stub_model(Task,
      :title => "MyString",
      :status => "MyString",
      :course => "MyString",
      :kind => "MyString"
    ))
  end

  it "renders the edit task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", task_path(@task), "post" do
      assert_select "input#task_title[name=?]", "task[title]"
      assert_select "input#task_status[name=?]", "task[status]"
      assert_select "input#task_course[name=?]", "task[course]"
      assert_select "input#task_kind[name=?]", "task[kind]"
    end
  end
end
