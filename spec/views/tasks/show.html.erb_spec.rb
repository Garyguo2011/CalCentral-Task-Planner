require 'spec_helper'

describe "tasks/show" do
  before(:each) do
    @task = assign(:task, stub_model(Task,
      :title => "Title",
      :status => "Status",
      :course => "Course",
      :kind => "Kind"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Status/)
    rendered.should match(/Course/)
    rendered.should match(/Kind/)
  end
end
