class Mood < ApplicationRecord
  belongs_to :user

  validates :mood, presence: true

  scope :weekly_moods, -> {
    order(created_at: :desc).limit(7)
  }

  scope :current_day_mood, -> {
    find_by('extract(day from created_at) = ?', Date.today.day)
  }
end
