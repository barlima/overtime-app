require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Creation" do

    before do
      user = User.create(email: "test@test.com", password: "asdfasdf", password_confirmation: "asdfasdf", first_name: "Josh", last_name: "Snow")
      login_as(user, scope: :user)
      @post = Post.create(date: Date.today, rationale: "Anything", user: user)
    end

    it "can be create" do
      expect(@post).to be_valid
    end

    it "cannot be create without a date and rationale" do
      @post.date = nil
      @post.rationale = nil
      expect(@post).to_not be_valid
    end
  end
end
