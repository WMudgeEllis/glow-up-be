class User < ApplicationRecord
  has_secure_password

  has_many :moods, dependent: :destroy
  has_many :journal_entries, dependent: :destroy
  has_many :journals, through: :journal_entries
  has_many :habit_entries, dependent: :destroy
  has_many :habits, through: :habit_entries

  validates :username, presence: true, uniqueness: true


  def all_journals
    journal_entries.all_journals
  end

  def weekly_habits
    habit_entries
      .where('habit_entries.created_at > ?', Date.today - 7)
      .group('habit_entries.created_at, habit_entries.id')
      .order('habit_entries.created_at DESC')
  end

  def monthly_habits(month)
    habit_entries
      .where('extract(month from habit_entries.created_at) = ?', month)
      .order('habit_entries.created_at DESC')
  end

  def weekly_moods
    moods.weekly_moods
  end

  def daily_habits
    habit_entries.daily_completed
  end

  def daily_mood
    moods.find_by(created_at: Date.current.all_day)
  end
end
