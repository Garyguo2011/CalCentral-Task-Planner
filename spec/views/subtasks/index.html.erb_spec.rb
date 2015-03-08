require 'spec_helper'

describe "subtasks/index" do
  before(:each) do
    assign(:subtasks, [
      stub_model(Subtask,
        :description => "Description",
        :is_done => false,
        :task => nil
      ),
      stub_model(Subtask,
        :description => "Description",
        :is_done => false,
        :task => nil
      )
    ])
  end

  it "renders a list of subtasks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
