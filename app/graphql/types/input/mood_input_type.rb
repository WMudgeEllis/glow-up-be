module Types
  module Input
    class MoodInputType < Types::BaseInputObject
      argument :mood, Integer, required: true
      argument :description, String, required: false
    end
  end
end
