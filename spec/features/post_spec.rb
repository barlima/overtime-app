require 'rails_helper'

describe 'navigate' do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user, overtime_request: 3.5) }

  before do
    login_as(user, scope: :user)
  end

  describe 'index' do
    before do
      visit posts_path
    end

    it "can be reached successfully" do
      expect(page.status_code).to eq(200)
    end

    it "has a title of Posts" do
      expect(page).to have_content(/Posts/)
    end

    it "has a list of posts" do
      post1 = FactoryBot.build_stubbed(:post)
      post2 = FactoryBot.build_stubbed(:second_post)
      visit posts_path
      expect(page).to have_content(/Rationale|Content/)
    end

    it "has a scope so the only post creators can see their posts" do
      other_user = FactoryBot.create(:non_authorized_user)
      post1 = FactoryBot.create(:post, user: user)
      post2 = FactoryBot.create(:second_post, user: user)
      post_from_other_user = FactoryBot.create(
        :post_from_other_user,
        user: other_user
      )

      visit posts_path

      expect(page).to_not have_content(/This should not be seen/)
    end
  end

  describe 'new' do
    it "has a link from the homepage" do
      visit root_path

      click_link "new_post_from_nav"
      expect(page.status_code).to eq(200)
    end
  end

  describe 'delete' do
    it 'can be deleted' do
      logout(:user)
      delete_user = FactoryBot.create(:user)
      login_as(delete_user, scope: :user)
      post_to_delete = FactoryBot.create(:post, user: delete_user, overtime_request: 3.5)

      visit posts_path

      click_link "delete_post_#{post_to_delete.id}_from_index"
      expect(page.status_code).to eq(200)
    end
  end

  describe 'creation' do
    before do
      visit new_post_path
    end

    it "has a new form that can be reached" do
      expect(page.status_code).to eq(200)
    end

    it "can be created from new form page" do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Some rationale"
      fill_in 'post[overtime_request]', with: 4.5

      expect { click_on "Save" }.to change(Post, :count).by(1)
    end

    it 'will have a user associated' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "User_Association"
      fill_in 'post[overtime_request]', with: 4.5
      click_on "Save"

      expect(User.last.posts.last.rationale).to eq("User_Association")
    end
  end

  describe "edit" do
    it "can be edited" do
      visit edit_post_path(post)

      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Edited content"
      click_on "Save"

      expect(User.last.posts.last.rationale).to eq("Edited content")
    end

    it "cannot be edited by non authorized user" do
      logout(:user)
      non_authorized_user = FactoryBot.create(:non_authorized_user)
      login_as(non_authorized_user, scope: :user)

      visit edit_post_path(post)

      expect(current_path).to eq(root_path)
    end
  end
end