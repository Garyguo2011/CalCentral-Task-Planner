require 'spec_helper'
require 'capybara/rspec'

describe "tasks/index", :type => :feature do
  before(:each) do
    assign(:tasks, [
      stub_model(Task,
        :title => 'Vatamin#5',
        :course => 'CS186',
        :kind => 'Homework',
        :release => '27/Feb/2015 23:59:00 -0800',
        :due => '2/Mar/2015 23:59:00 -0800',
        :status => 'Complete',
        :user_id => 1
      ),
      stub_model(Task,
        :title => 'Quiz#2',
        :course => 'CS169',
        :kind => 'Exam',
        :release => '12/Mar/2015 23:59:00 -0800',
        :due => '19/Mar/2015 23:59:00 -0800',
        :status => 'New',
        :user_id => 1
      )
    ])
    assign(:current_user,[
      stub_model(User,
        id: 1,
        email: "xguo@berkeley.edu",
        encrypted_password: "$2a$10$QhhefbsnAaUmELAf1eyUoOBpE3hl1YEkTkeztZNO3dqo...",
        first_name: "Xinran",
        last_name: "Guo",
        reset_password_token: "54c96fbcbf99faa92660eaabfc109d7ebf4d63c8c6767f38f6e...",
        reset_password_sent_at: "2015-03-10 02:36:44",
        remember_created_at: nil,
        sign_in_count: 28,
        current_sign_in_at: "2015-03-10 05:25:18",
        last_sign_in_at: "2015-03-10 05:23:20",
        current_sign_in_ip: "127.0.0.1",
        last_sign_in_ip: "127.0.0.1",
        created_at: "2015-03-08 07:42:58",
        updated_at: "2015-03-10 05:25:18"
      )
    ])
  end

  it "renders a list of tasks", :type => :feature do
    render
    # rendered.should contain("Vatamin#5")
    # Run the generator again with the --webrat flag if you want to use webrat matchers

    assert_select "tr>td", :text => "Vatamin#5".to_s, :count => 1
    assert_select "tr>td", :text => "Quiz#2".to_s, :count => 1
    # assert_select "tr>td", :text => "Course".to_s, :count => 2
    # assert_select "tr>td", :text => "Kind".to_s, :count => 2
  end
end
