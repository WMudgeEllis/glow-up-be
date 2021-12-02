class Removedatefrommood < ActiveRecord::Migration[5.2]
  def change
    remove_column :moods, :date
  end
end
