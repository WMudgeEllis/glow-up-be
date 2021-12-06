class HabitEntry < ApplicationRecord
  belongs_to :user
  belongs_to :habit

  def self.create_neglected(user, habit_ids)
    neglected = Habit.where.not(id: habit_ids)
    neglected.each do |habit|
      user.habit_entries.create!(habit_id: habit.id, status: 0)
    end
  end

  def self.create_entries(user, habits)
    destroy_today_entries(user)
    habit_ids = habits.map { |habits| habits[:id] }

    habit_ids.each do |habit_ids|
      user.habit_entries.create!(habit_id: habit_ids, status: 1)
    end

    #gets array of habit ids where there are no entries for today
    neglected = Habit.select('habits.id')
      .left_joins(:habit_entries)
      .where(habit_entries: {user_id: user.id})
      .where('habit_entries.created_at > ?', Date.today)
      .distinct.pluck('habits.id')

    create_neglected(user, neglected)
  end

  def self.destroy_today_entries(user)
    where('created_at > ?', Date.today)
      .where(user_id: user.id)
      .destroy_all
  end
  scope :completed, -> {
    where(status: 1)
  }

  scope :current_day, -> {
    where('extract(day from created_at) = ?', Date.today.day)
  }

  scope :daily_completed, -> {
    completed
      .current_day
      .pluck(:habit_id)
  }
end
