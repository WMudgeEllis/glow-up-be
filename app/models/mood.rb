class Mood < ApplicationRecord
  belongs_to :user

  validates :mood, presence: true

  scope :weekly_moods, -> {
    order(created_at: :desc).limit(7)
  }

  scope :current_day_mood, -> {
    find_by('extract(day from created_at) = ?', Time.now.utc.to_date.day)
  }

  scope :monthly_moods, ->(month) {
    order(created_at: :desc)
      .where('extract(month from created_at) = ?', month)
  }
end
