class ChangeDatatypeOfStatusToTasks < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :status, :integer, using: 'status::integer'
  end
end
