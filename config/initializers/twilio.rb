Twilio.configure do |config|
    config.account_sid = Rails.application.credentials.dig(:TWILIO_ACCOUNT_SID) || ENV['TWILIO_ACCOUNT_SID']
    config.auth_token = Rails.application.credentials.dig(:TWILIO_AUTH_TOKEN) || ENV['TWILIO_AUTH_TOKEN']
  end
  