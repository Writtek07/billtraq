# Using update_column all places as we have discrepancy(missing fields in records) in current data in app. 
# Hence bypassing all validations during update
module Services
    class FeeReminderService        
        def self.send_fee_reminder_message(student)
            phone_number = student.phone_number
            # phone_number = "+918839390992"
            if student.phone_number.present?
                message = "Dear Parents, this is a reminder about your ward's pending fees. Please clear it as soon as possible. 
                Regards, Mimis Kids School."
                
                response = Services::SmsService.send_invoice_message(phone_number, message)                    
                if response[:success]
                    student.update_column(:sms_status, :sent)
                    student.update_column(:message, message)
                    student.update_column(:sent_at, Time.now)
                    student.update_column(:sms_sent_count, student.sms_sent_count + 1 )                    
                else                
                    student.update_column(:sms_status, :error)
                    error_message = response[:error_message]
                    student.update_column(:message, error_message)
                    student.update_column(:sent_at, Time.now)                    
                end
                response             
            else
                message = "Number not present for the student"
                student.update_column(:sms_status, :error)
                student.update_column(:message, message)
                student.update_column(:sent_at, Time.now)
                { success: false, error_message: message }
            end
        end
    end
end