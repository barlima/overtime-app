FactoryBot.define do
  factory :post do
    date Date.today
    work_performed "Some work_performed"
    daily_hours 3.5
    user
  end

  factory :second_post, class: "Post" do
    date Date.yesterday
    work_performed "Some work_performed"
    daily_hours 0.5
    user
  end

  factory :post_from_other_user, class: "Post" do
    date Date.yesterday
    work_performed "This should not be seen"
    daily_hours 1.5
    user
  end
end
