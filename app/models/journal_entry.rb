class JournalEntry < ApplicationRecord
  belongs_to :user
  belongs_to :journal

  scope :all_journals, -> {
    order(created_at: :desc)
  }
end
