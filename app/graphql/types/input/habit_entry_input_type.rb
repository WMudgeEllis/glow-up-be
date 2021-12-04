module Types
  module Input
    class HabitEntryInputType < Types::BaseInputObject
      argument :id, Integer, required: true
    end
  end
end
