class JournalEntry < ApplicationRecord
  belongs_to :user
  belongs_to :journal

  scope :weekly_journal, -> {
    order(created_at: :desc).limit(7)
  }
end
