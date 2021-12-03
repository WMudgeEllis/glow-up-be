require 'rails_helper'

describe 'Create Mood Mutation' do
  let!(:user) { create :user }

  it 'creates a mood for the user' do
    expect { post '/graphql', params: { query: query } }
      .to change(Mood, :count)
      .by 1
  end

  def query
    <<-GQL
      mutation {
        createMood(
          input: {
            params: {
              mood: 1,
              description: "hello"
            }
          }
        ) {
          user {
            id
          }
        }
      }
    GQL
  end
end
