module Services
  class SmsService
      def self.send_invoice_message(phone_number, message)
        client = Twilio::REST::Client.new      
        from_number = Rails.application.credentials.dig(:TWILIO_PHONE_NUMBER) || ENV['TWILIO_PHONE_NUMBER']
    
        begin
          client.messages.create(
            from: from_number,
            to: phone_number,
            body: message
          )
        rescue Twilio::REST::TwilioError => e
          puts "Error sending SMS: #{e.message}"
        end
      end
    end
end