class AddRestrictionToTasksDeadline < ActiveRecord::Migration[6.1]
  # def change
  #   # today = Date.today
  #   # one_week_later = today + 1.week
    
  #   # change_column_default :tasks, :deadline, from: nil, to: one_week_later
  #   # change_column_null :tasks, :deadline, false
  #   # change_column_default :tasks, :deadline, from: nil, to: Date.today + 1.week
  #   # execute("ALTER TABLE tasks ALTER COLUMN deadline SET DEFAULT (CURRENT_DATE + INTERVAL '7 days')")
  #   end
    def up
      change_column :tasks, :deadline, :date, default: "2023/12/31", null: false
      # change_column_default :tasks, :deadline, from: nil, to: '(CURRENT_DATE + INTERVAL 7 DAY)'
      # change_column_null :tasks, :deadline, false
    end
end
