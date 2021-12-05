class RemoveDescriptionFromHabits < ActiveRecord::Migration[5.2]
  def change
    remove_column :habits, :description, :string
  end
end
