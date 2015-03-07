class CreateSubtasks < ActiveRecord::Migration
  def change
    create_table :subtasks do |t|
      t.string :description
      t.boolean :is_done
      t.references :task

      t.timestamps
    end
    add_index :subtasks, :task_id
  end
end
