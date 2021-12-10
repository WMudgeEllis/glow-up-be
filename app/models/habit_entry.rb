class HabitEntry < ApplicationRecord
  belongs_to :user
  belongs_to :habit

  scope :current_day, -> {
    where('extract(day from created_at) = ?', Date.current.day)
  }

  scope :daily_completed, -> {
    current_day.pluck(:habit_id)
  }

  def self.destroy_today_entries(user)
    current_day
      .where(user_id: user.id)
      .destroy_all
  end

  def self.create_entries(user, habits)
    destroy_today_entries(user)
    completed_ids = habits.map { |habits| habits[:id] }

    completed_ids.each do |habit_id|
      user.habit_entries.create!(habit_id: habit_id)
    end
  end
end
