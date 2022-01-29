class Mood < ApplicationRecord
  belongs_to :user

  validates :mood, presence: true

  def date
    created_at.strftime('%m/%d/%Y')
  end

  scope :weekly_moods, -> {
    where(created_at: (Date.current - 6)..Date.current.end_of_day)
      .order(created_at: :desc)
  }

  scope :current_day_mood, -> {
    find_by('extract(day from created_at) = ?', Date.current.day)
  }

  scope :monthly_moods, ->(month) {
    order(created_at: :desc)
      .where('extract(month from created_at) = ?', month)
  }
end
