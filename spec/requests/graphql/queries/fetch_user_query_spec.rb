require 'rails_helper'

describe 'Fetch User Query' do
  let(:query) do
    <<~GQL
      query fetchUser {
        fetchUser {
          id
          username
          journals {
            id
            name
            details
          }
          journalEntries {
            id
            createdAt
            content
          }
          habits {
            id
            name
            description
          }
          habitEntries {
            id
            status
          }
        }
      }
    GQL
  end
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:reduced) { json[:data] }
  let(:data) { reduced[:fetchUser]}

  let!(:user) do
    FactoryBot.create(:user) do |user|
      FactoryBot.create(:journal) do |journal|
        FactoryBot.create_list :journal_entry, 5, journal_id: journal.id, user_id: user.id
      end
      FactoryBot.create(:habit) do |habit|
        FactoryBot.create_list :habit_entry, 5, user_id: user.id, habit_id: habit.id
      end
    end
  end

  before { post '/graphql', params: { query: query } }

  it 'returns user info' do
    expect(data[:id]).to_not be_empty
    expect(data[:username]).to_not be_empty
    expect(data[:journals]).to_not be_empty
    expect(data[:journalEntries]).to_not be_empty
    expect(data[:habits]).to_not be_empty
    expect(data[:habitEntries]).to_not be_empty
  end

  it 'returns journal info' do
    expect(data[:journals].size).to eq 1

    data[:journals].each do |journal|
      expect(journal[:id]).to_not be_empty
      expect(journal[:name]).to_not be_empty
      expect(journal[:details]).to_not be_empty
    end
  end

  it 'returns journal entry info' do
    expect(data[:journalEntries].size).to eq 5

    data[:journalEntries].each do |entry|
      expect(entry[:id]).to_not be_empty
      expect(entry[:createdAt]).to_not be_empty
      expect(entry[:content]).to_not be_empty
    end
  end

  it 'returns habit info' do
    expect(data[:habits].size).to eq 1

    data[:habits].each do |habit|
      expect(habit[:id]).to_not be_empty
      expect(habit[:name]).to_not be_empty
      expect(habit[:description]).to_not be_empty
    end
  end

  it 'returns habit entry info' do
    expect(data[:habitEntries].size).to eq 5

    data[:habitEntries].each do |entry|
      expect(entry[:id]).to_not be_empty
      expect(entry[:status]).to be_an Integer
    end
  end
end
