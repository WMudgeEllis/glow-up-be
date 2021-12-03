require 'rails_helper'

describe 'Fetch User Query Relationships' do
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:reduced) { json[:data] }
  let(:data) { reduced[:fetchUser] }

  let!(:user) do
    create(:user) do |user|
      create_list(:mood, 40)
    end
  end

  it 'sojgts' do

  end
end
