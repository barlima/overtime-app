@employee = Employee.create(email: "test@test.com", 
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

puts "1 employee created"

AuditLog.create!(user: @employee, status: 0, start_date: (Date.today - 6.days))
AuditLog.create!(user: @employee, status: 0, start_date: (Date.today - 13.days))
AuditLog.create!(user: @employee, status: 0, start_date: (Date.today - 20.days))

puts "3 audit_logs have been created"

100.times do |post| 
  Post.create!(date: Date.today, rationale: "#{post} rationale content", user_id: @employee.id, overtime_request: 2.5)
end

puts "100 posts have been created"
