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
    let!(:moods) { create_list :mood, 7, user_id: user.id }
    let!(:habit_entries) { create_list :habit_entry, 7, user_id: user.id }
    let!(:past_habit_entries) { create_list :habit_entry, 7, user_id: user.id, created_at: Date.today - 8 }

    it 'returns moods for the week' do
      expect(user.weekly_moods).to eq(moods.reverse)
    end

    it 'has weekly habit entries grouped by created at' do
      expect(user.weekly_habits).to eq(habit_entries.reverse)
    end
  end
end
