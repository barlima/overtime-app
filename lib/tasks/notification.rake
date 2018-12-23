namespace :notification do
  desc 'Sends SMS notification to employyes asking them to log if they have overtime or not'
  task sms: :environment do
    # 4. Send a message that has instructions and a link to log time
    employees = Employee.all
    notification_message =
      "Please log into the overtime management dashboard to request overtime time or confirm your hours for last week: #{'LINK'}"

    employees.each do |employee|
      AuditLog.create!(user: employee)
      SmsTool.send_sms(number: employee.phone, message: notification_message)
    end
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
