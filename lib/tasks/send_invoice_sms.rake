namespace :twilio do
    desc 'Send daily invoice SMS'
    task send_invoice_sms: :environment do
        phone_number = '+918839390992'
        today = Date.today
        cash_total = Invoice.where(created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day, payment_mode: 'Cash').sum(:total)
        online_total = Invoice.where(created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day, payment_mode: 'Online').sum(:total)
        total = cash_total + online_total
        message = "Total for #{today}. Cash - #{cash_total} | Online - #{online_total}"
    
  
        SmsService.send_invoice_reminder(phone_number, message)
    end
  end
  
