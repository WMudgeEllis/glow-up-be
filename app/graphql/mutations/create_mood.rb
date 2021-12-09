module Mutations
  class CreateMood < Mutations::BaseMutation
    argument :params, Types::Input::MoodInputType, required: true

    field :user, Types::UserType, null: false

    def resolve(params:)
      mood_params = Hash params
      user = User.first
      user.daily_mood.destroy if user.daily_mood.present?
      user.moods.create!(mood_params)

      { user: user }
    end
  end
end
