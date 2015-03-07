class AddFieldsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :course, :string
    add_column :tasks, :kind, :string
    add_column :tasks, :release, :datetime
  end
end
