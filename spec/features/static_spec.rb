require 'rails_helper'

describe 'navigate' do
  describe 'navigate' do
    it 'can be reached sucessfully' do
      visit root_path
      expect(page.status_code).to eq(200)
    end
  end
end