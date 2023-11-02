class RemoveDefaultFromStatusToTasks < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :status, nil
  end
end
