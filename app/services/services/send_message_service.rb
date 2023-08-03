module Services
    class SendMessageService
        def self.send_message(student,message)
            if student.phone_number.present?
                phone_number = student.phone_number                            
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