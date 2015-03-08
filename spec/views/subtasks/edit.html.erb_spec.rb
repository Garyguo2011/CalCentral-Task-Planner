require 'spec_helper'

describe "subtasks/edit" do
  before(:each) do
    @subtask = assign(:subtask, stub_model(Subtask,
      :description => "MyString",
      :is_done => false,
      :task => nil
    ))
  end

  it "renders the edit subtask form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", subtask_path(@subtask), "post" do
      assert_select "input#subtask_description[name=?]", "subtask[description]"
      assert_select "input#subtask_is_done[name=?]", "subtask[is_done]"
      assert_select "input#subtask_task[name=?]", "subtask[task]"
    end
  end
end
