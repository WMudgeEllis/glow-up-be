require 'rails_helper'

RSpec.describe Mood, type: :model do
  it { should belong_to :user }
  it { should validate_presence_of :mood }
end
