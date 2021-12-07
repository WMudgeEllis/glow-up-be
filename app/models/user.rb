class User < ApplicationRecord
  has_secure_password

  has_many :moods, dependent: :destroy
  has_many :journal_entries, dependent: :destroy
  has_many :journals, through: :journal_entries
  has_many :habit_entries, dependent: :destroy
  has_many :habits, through: :habit_entries

  validates :username, presence: true, uniqueness: true


  def weekly_journals
    journal_entries.weekly_journal
  end

  def weekly_habits
    habit_entries
      .where('habit_entries.created_at > ?', Date.today - 7)
      .group('habit_entries.created_at, habit_entries.id')
      .order('habit_entries.created_at DESC')
  end

  def weekly_moods
    moods.weekly_moods
  end

  def daily_habits
    habit_entries.daily_completed
  end

  def daily_mood
    moods.current_day_mood
  end
end
