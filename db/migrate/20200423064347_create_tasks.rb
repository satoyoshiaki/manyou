class CreateTasks < ActiveRecord::Migration[5.2]
  change_column :tasks, :task_name, :string, null: false
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.text :description

      t.timestamps
    end
  end
end
