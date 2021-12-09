module Types
  class HabitEntryType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: true
    field :habit_id, Integer, null: true
    field :date, String, null: false

    def date
      object.created_at
    end
  end
end
