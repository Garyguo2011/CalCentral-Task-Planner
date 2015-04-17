class AddEmailNotificationsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :email_notifications, :string
  end
end
