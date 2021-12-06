class HabitEntry < ApplicationRecord
  belongs_to :user
  belongs_to :habit

  def self.create_neglected(user, habits)
    habit_ids = habits.map { |habits| habits[:id] }
    neglected = Habit.where.not(id: habit_ids)
    neglected.each do |habit|
      user.habit_entries.create!(habit_id: habit.id, status: 0)
    end
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
