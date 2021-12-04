class Mood < ApplicationRecord
  belongs_to :user

  validates :mood, presence: true

  scope :weekly_moods, -> {
    order(created_at: :desc).limit(7)
  }
end
