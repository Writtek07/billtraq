namespace :twilio do
    desc 'Send daily invoice SMS'
    task send_invoice_sms: :environment do
        phone_number = ['+918839390992','+919827157664','+919329385300','+919827906446']
        today = Date.today
        cash_total = Invoice.where(created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day, payment_mode: 'Cash').sum(:total)
        online_total = Invoice.where(created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day, payment_mode: 'Online').sum(:total)
        total = cash_total + online_total
        message = "Total for #{today} - #{total}. Cash - #{cash_total} | Online - #{online_total}"
    
        phone_number.each do |phn|
            SmsService.send_invoice_reminder(phn, message)
        end
    end
  end
