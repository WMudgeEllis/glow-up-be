require 'rails_helper'

RSpec.describe Mood, type: :model do
  it { should belong_to :user }
  it { should validate_presence_of :mood }

  describe 'scopes' do
    let!(:user) { create :user }
    let!(:moods) { create_list :mood, 7, user_id: user.id }
    let!(:past_moods) { create_list :mood, 5, created_at: Date.today - 8, user_id: user.id }

    it 'returns moods for the week' do
      expect(user.moods.weekly_moods).to eq(moods.reverse)
    end
  end
end
