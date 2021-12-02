class CreateJournalEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :journal_entries do |t|
      t.datetime :date
      t.string :content
      t.references :user, foreign_key: true
      t.references :journal, foreign_key: true

      t.timestamps
    end
  end
end
