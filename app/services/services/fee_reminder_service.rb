# Using update_column all places as we have discrepancy(missing fields in records) in current data in app. 
# Hence bypassing all validations during update
module Services
    class FeeReminderService        
        def self.send_fee_reminder_message(student)            
            message = "Dear Parents, this is a reminder about your ward's pending fees. Please clear it as soon as possible. 
                Regards, Mimis Kids School."
            Services::SendMessageService.send_message(student,message)
        end
    end
end