class RemoveStatusFromHabitEntries < ActiveRecord::Migration[5.2]
  def change
    remove_column :habit_entries, :status
  end
end
