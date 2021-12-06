require 'rails_helper'

RSpec.describe Mood, type: :model do
  describe 'validations and relationships' do
    it { should belong_to :user }
    it { should validate_presence_of :mood }
  end

  describe 'scopes' do
    let!(:user) { create :user }
    let!(:mood_of_day) { create :mood, user_id: user.id }
    let!(:moods) { create_list :mood, 6, user_id: user.id, created_at: Date.today - 1 }
    let!(:past_moods) { create_list :mood, 5, created_at: Date.today - 8, user_id: user.id }
    let!(:monthly_mood) { create_list :mood, 30, created_at: '2021-11-21', user_id: user.id }
    let!(:dec_moods) { create_list :mood, 5, created_at: '2021-12-12', user_id: user.id}

    it 'returns moods for the week' do
      result = user.moods.weekly_moods

      expect(result).to eq(moods.unshift(mood_of_day))
    end

    it 'returns mood for the day' do
      expect(user.moods.current_day_mood).to eq(mood_of_day)
    end

    it 'returns moods for the month' do
      expect(user.moods.monthly_moods(11)).to eq(monthly_mood)
    end
  end
end
