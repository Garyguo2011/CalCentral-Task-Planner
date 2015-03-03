class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.datetime :due
      t.string :status

      t.timestamps
    end
  end
end
