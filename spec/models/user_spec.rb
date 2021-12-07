require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :username }
    it { should validate_uniqueness_of :username }
  end

  describe 'relationships' do
    it { should have_many :moods }
    it { should have_many :journal_entries }
    it { should have_many(:journals).through :journal_entries }
    it { should have_many :habit_entries }
    it { should have_many(:habits).through :habit_entries }
  end

  describe 'scopes' do
    let!(:user) { create :user }
    let!(:past_moods) { create_list :mood, 5, created_at: Date.today - 8, user_id: user.id }
    let!(:current_day_mood) { create :mood, user_id: user.id }
    let!(:moods) { create_list :mood, 6, user_id: user.id, created_at: Date.today - 1 }
    let!(:habit_entries) { create_list :habit_entry, 4, user_id: user.id, status: 0 }
    let!(:completed_habit_entries) { create_list :habit_entry, 4, user_id: user.id, status: 1 }
    let!(:past_habit_entries) { create_list :habit_entry, 7, user_id: user.id, created_at: Date.today - 8 }
    let!(:journal_entries) { create_list :journal_entry, 7, user_id: user.id}
    let!(:past_journal_entries) { create_list :journal_entry, 7, user_id: user.id, created_at: Date.today - 8}

    it 'returns moods for the week' do
      (moods << current_day_mood).each do |mood|
        expect(user.weekly_moods).to include(mood)
      end
      expect(user.weekly_moods).to_not include(past_moods.first)
      expect(user.weekly_moods).to_not include(past_moods.last)
    end

    it 'has weekly habit entries grouped by created at' do
      expected = habit_entries + completed_habit_entries
      expect(user.weekly_habits).to eq(expected.reverse)
    end

    it 'has habits completed for the day' do
      expect(user.daily_habits).to eq(completed_habit_entries.map(&:habit_id))
    end

    it 'has mood of the day' do
      expect(user.daily_mood).to eq(current_day_mood)
    end

    it 'shows 7 journal entries' do
      expect(user.weekly_journals).to eq(journal_entries.reverse)
    end
  end
end
