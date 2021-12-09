class JournalEntry < ApplicationRecord
  belongs_to :user
  belongs_to :journal

  scope :weekly_journal, -> {
    order(created_at: :desc).limit(7)
  }

  scope :create_entries, ->(user, entries) {
    entries.each do |entry_id|
      user.journal_entries.create!(journal_entry_id: entries[:id])
    end
  }
end
