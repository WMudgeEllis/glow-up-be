require 'rails_helper'

describe 'Fetch User Query Relationships' do
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:reduced) { json[:data] }
  let(:data) { reduced[:fetchUser] }

  let!(:user) do
    create(:user) do |user|
      create(:journal) do |journal|
        create_list :journal_entry, 10, journal_id: journal.id, user_id: user.id
      end
      create(:habit) do |habit|
        create_list :habit_entry, 2, user_id: user.id, habit_id: habit.id
        create_list :habit_entry, 3, user_id: user.id, habit_id: habit.id
      end
    end
  end

  before { post '/graphql', params: { query: query } }

  it 'returns user info' do
    expect(data[:id]).to_not be_empty
    expect(data[:username]).to_not be_empty
    expect(data[:journalEntries]).to_not be_empty
  end

  it 'returns journal entry info' do
    expect(data[:journalEntries].size).to eq 10

    data[:journalEntries].each do |entry|
      expect(entry[:id]).to_not be_empty
      expect(entry[:date]).to_not be_empty
      expect(entry[:content]).to_not be_empty
    end
  end

  it 'returns weekly habits' do
    expect(data[:weeklyHabits].size).to eq 5
  end

  def query
    <<~GQL
      query fetchUser {
        fetchUser(token: "#{user_token}") {
          id
          username
          journalEntries {
            id
            date
            content
          }
          weeklyHabits {
            id
          }
        }
      }
    GQL
  end

  def login_query
    <<-GQL
      mutation{
        signInUser(
          input:{
            params:{
              username: "#{user.username}",
              password: "#{user.password}",
            }
          }
        ) {
        user {
          username
        }
        token
        }
      }
    GQL
  end

  def user_token
    post '/graphql', params: { query: login_query }

    body = JSON.parse(response.body, symbolize_names: true)

    body[:data][:signInUser][:token]
  end
end
