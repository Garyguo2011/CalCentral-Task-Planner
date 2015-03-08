require 'spec_helper'

describe "subtasks/new" do
  before(:each) do
    assign(:subtask, stub_model(Subtask,
      :description => "MyString",
      :is_done => false,
      :task => nil
    ).as_new_record)
  end

  it "renders new subtask form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", subtasks_path, "post" do
      assert_select "input#subtask_description[name=?]", "subtask[description]"
      assert_select "input#subtask_is_done[name=?]", "subtask[is_done]"
      assert_select "input#subtask_task[name=?]", "subtask[task]"
    end
  end
end
