require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Creation" do

    before do
      user = FactoryBot.create(:user)
      login_as(user, scope: :user)
      @post = FactoryBot.create(:post)
    end

    it "can be create" do
      expect(@post).to be_valid
    end

    it "cannot be create without a date, work_performed and daily_hours" do
      @post.date = nil
      @post.work_performed = nil
      @post.daily_hours = nil
      expect(@post).to_not be_valid
    end

    it "has an daily_hours greater than 0.0" do
      @post.daily_hours = 0.0
      expect(@post).to_not be_valid
    end
  end
end
