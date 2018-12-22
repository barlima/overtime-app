namespace :notification do
  desc 'Sends SMS notification to employyes asking them to log if they have overtime or not'
  task sms: :environment do
    # 1. Schedule to run at Sunday at 5pm
    # 2. Iterate over all employees
    # 3. Skip AdminUsers
    # 4. Send a message that has instructions and a link to log time

    # User.all.each do |user|
    #   SmsTool.send_sms()
    # end
  end

  desc 'Sends mail notification to managers each day to inform of pending overtime requests'
  task manager_email: :environment do
    # 1. Iterate over the list of pending overtime requests
    # 2. Check to see if there are any requests
    # 3. Iterate over the list of admin users / manager
    # 4. Send an email to each admin
    submitted_posts = Post.submitted
    admin_users = AdminUser.all

    if submitted_posts.any?
      admin_users.each do |admin|
        ManagerMailer.email(admin).deliver_now
      end
    end
  end
end
