require 'rails_helper'

describe 'create journal entry mutation' do
  it 'creates a journal entry' do
    create(:user)
    create(:journal)
    expect { post '/graphql', params: {query: query } }
    .to change(JournalEntry, :count)
    .by 1
  end
end

def query
  <<-GQL
  mutation {
    createJournalEntry(
      input: {
        params: {
          content: "hello"
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
