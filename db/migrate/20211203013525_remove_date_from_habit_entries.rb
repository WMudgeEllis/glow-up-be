class RemoveDateFromHabitEntries < ActiveRecord::Migration[5.2]
  def change
    remove_column :habit_entries, :date
  end
end
