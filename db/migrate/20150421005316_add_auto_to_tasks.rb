class AddAutoToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :auto, :boolean
  end
end
