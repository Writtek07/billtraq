module Services
    class FeeReminderService        
        def self.send_fee_reminder_message(student)
            phone_number = student.phone_number
            # phone_number = "+918839390992"
            if student.phone_number.present?
                message = "Dear #{student.father_name}, this is a reminder about your ward's pending fees. Please clear it as soon as possible. 
                Regards, Mimis Kids School."
        
                begin
                Services::SmsService.send_invoice_message(phone_number, message)
                student.sent!
                student.update(message: message, sent_at: Time.now, sms_sent_count: student.sms_sent_count+1 )
                rescue Twilio::REST::TwilioError => e
                puts "Error sending SMS: #{e.message}"
                student.error!
                student.update(message: e.message, sent_at: Time.now)
                end
            else
                message = "Number not present for the student"
                student.error!
                student.update(message: message, sent_at: Time.now)
            end
        end
    end
end