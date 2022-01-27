require 'rails_helper'

describe 'create journal entry mutation' do
  let!(:user) { create :user }
  let!(:token) { user.generate_token }
  let!(:journal) { create :journal }

  it 'creates a journal entry' do
    expect { post '/graphql', params: { query: valid_query(user_token: token) } }
      .to change(JournalEntry, :count)
      .by 1
  end
end

def valid_query(user_token:)
  <<-GQL
  mutation {
    createJournalEntry(
      input: {
        params: {
          content: "hello"
        },
        userToken: "#{user_token}"
      }
    ) {
      user {
        id
      }
    }
  }
  GQL
end
