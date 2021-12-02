class CreateHabitEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :habit_entries do |t|
      t.datetime :date
      t.integer :status
      t.references :user, foreign_key: true
      t.references :habit, foreign_key: true

      t.timestamps
    end
  end
end
