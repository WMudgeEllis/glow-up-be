require 'rails_helper'

describe 'Create Mood Mutation' do
  let!(:user) { create :user }

  it 'creates a mood for the user' do
    expect { post '/graphql', params: { query: query } }
      .to change(Mood, :count)
      .by 1
  end

  it 'returns error message if invalid query input' do
    expect { post '/graphql', params: { query: invalid_query } }
      .to change(Mood, :count)
      .by 0

    expect(JSON.parse(response.body)).to have_key 'errors'
  end

  it 'return error with ActiveRecord' do
    expect { post '/graphql', params: { query: bad_query } }
      .to change(Mood, :count)
      .by 0

    expect(JSON.parse(response.body)).to have_key 'errors'
  end

  it 'deletes previous daily mood' do
    create(:mood, user_id: user.id)

    expect { post '/graphql', params: { query: query } }
      .to change(Mood, :count)
      .by 0
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

  def invalid_query
    <<-GQL
      mutation {
        createMood(
          input: {
            params: {
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

  def bad_query
    <<-GQL
      mutation {
        createMood(
          input: {
            params: {
              description: ""
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
