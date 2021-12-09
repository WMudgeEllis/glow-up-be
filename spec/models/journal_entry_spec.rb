require 'rails_helper'

RSpec.describe JournalEntry, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :journal }
  end
  describe 'scopes' do

    let!(:user) { create :user }
    let!(:journal) { create :journal}
    let!(:journal_entry) { create_list :journal_entry, 7, user_id: user.id, journal_id: journal.id }

    it 'returns all journal entries' do
      expect(user.journal_entries.all_journals).to eq(journal_entry.reverse)
    end
  end
end
