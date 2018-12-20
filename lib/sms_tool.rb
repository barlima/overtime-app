module SmsTool
  account_sid = ENV['TWILIO_ACCOUNT_SID']
  auth_token = ENV['TWILIO_AUTH_TOKEN']

  @client = Twilio::REST::Client.new account_sid, auth_token

  def self.send_sms(number:, message:)
    if ENV['RAILS_ENV'] == 'production'
      @client.messages.create(
        from: ENV['TWILIO_PHONE_NUMBER'],
        to: "+1#{number}",
        body: "#{message}"
      )
    else
      puts 'Sending SMS...'
      puts "#{message} to #{number}"
    end
  end
end
