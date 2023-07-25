namespace :TWILIO do
    desc 'Send daily fee reminder SMS and update student records with status'
    task SendDailyFeeReminders: :environment do        
        students_with_pending_fees = Student.where(fee_pending: true).where.not(sent_at: Time.zone.now - 15.days .. Time.zone.now).kept
        # students_with_pending_fees = Student.where(fee_pending: true).last(3)
        students_with_pending_fees.each do |student|
            Services::FeeReminderService.send_fee_reminder_message(student)
        end
    end
end