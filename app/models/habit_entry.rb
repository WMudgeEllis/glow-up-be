class HabitEntry < ApplicationRecord
  belongs_to :user
  belongs_to :habit

  scope :completed, -> {
    where(status: 1)
  }

  scope :current_day, -> {
    where('extract(day from created_at) = ?', Time.now.utc.to_date.day)
  }

  scope :daily_completed, -> {
    completed
      .current_day
      .pluck(:habit_id)
  }

  def self.destroy_today_entries(user)
    current_day
      .where(user_id: user.id)
      .destroy_all
  end

  def self.create_neglected(user, completed_ids)
    neglected = Habit.where.not(id: completed_ids)
    neglected.each do |habit|
      user.habit_entries.create!(habit_id: habit.id, status: 0)
    end
  end

  def self.create_entries(user, habits)
    destroy_today_entries(user)
    completed_ids = habits.map { |habits| habits[:id] }

    completed_ids.each do |habit_id|
      user.habit_entries.create!(habit_id: habit_id, status: 1)
    end

    create_neglected(user, completed_ids)
  end
end
