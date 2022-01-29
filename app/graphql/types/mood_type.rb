module Types
  class MoodType < Types::BaseObject
    field :id, ID, null: false
    field :mood, Integer, null: false
    field :description, String, null: true
    field :created_at, String, null: false

    def created_at
      object.date
    end
  end
end
