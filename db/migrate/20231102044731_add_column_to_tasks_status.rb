class AddColumnToTasksStatus < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :status, :string, default: "waiting", null: false
  end
end
