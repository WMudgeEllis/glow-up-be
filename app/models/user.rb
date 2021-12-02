class User < ApplicationRecord
  has_secure_password

  has_many :moods, dependent: :destroy
  has_many :journal_entries, dependent: :destroy
  has_many :journals, through: :journal_entries
  has_many :habit_entries, dependent: :destroy
  has_many :habits, through: :habit_entries

  validates :username, presence: true, uniqueness: true
end
