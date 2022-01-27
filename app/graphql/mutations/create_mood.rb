module Mutations
  class CreateMood < Mutations::BaseMutation
    argument :params, Types::Input::MoodInputType, required: true
    argument :user_token, String, required: true

    field :user, Types::UserType, null: false

    def resolve(params:, user_token:)
      mood_params = Hash params
      user = User.decrypt_and_find(user_token)

      user.daily_mood.destroy if user.daily_mood.present?
      user.moods.create!(mood_params)

      { user: user }
    end
  end
end
