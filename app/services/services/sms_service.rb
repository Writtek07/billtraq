module Services
  class SmsService
      def self.send_invoice_message(phone_number, message)
        client = Twilio::REST::Client.new      
        from_number = Rails.application.credentials.dig(:TWILIO_PHONE_NUMBER) || ENV['TWILIO_PHONE_NUMBER']
    
        begin
          response = client.messages.create(
            from: from_number,
            to: phone_number,
            body: message
          )
          { success: true, response: response }
        rescue Twilio::REST::TwilioError => e
          puts "Error sending SMS: #{e.message}"  
          { success: false, error_message: e.message }        
        end        
      end
    end
end