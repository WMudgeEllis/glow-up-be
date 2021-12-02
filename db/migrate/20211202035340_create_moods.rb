class CreateMoods < ActiveRecord::Migration[5.2]
  def change
    create_table :moods do |t|
      t.datetime :date
      t.integer :mood
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
