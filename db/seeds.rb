@user = User.create(email: "test@test.com", 
                    password: "asdfasdf", 
                    password_confirmation: "asdfasdf", 
                    first_name: "Josh", 
                    last_name: "Snow",
                    phone: "4322386131")

AdminUser.create(email: "admin@user.com", 
                  password: "asdfasdf", 
                  password_confirmation: "asdfasdf", 
                  first_name: "Admin", 
                  last_name: "User",
                  phone: "4322386131")

puts "1 user created"

100.times do |post| 
  Post.create!(date: Date.today, rationale: "#{post} rationale content", user_id: @user.id, overtime_request: 2.5)
end

puts "100 posts have been created"

100.times do |audit_log| 
  AuditLog.create!(user: @user, status: 0, start_date: (Date.today - 6.days))
end

puts "100 audit_logs have been created"