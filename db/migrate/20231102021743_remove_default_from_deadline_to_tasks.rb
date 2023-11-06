class RemoveDefaultFromDeadlineToTasks < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :deadline, nil
  end
end
