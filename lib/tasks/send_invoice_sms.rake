namespace :twilio do
    desc 'Send daily invoice SMS'
    task send_invoice_sms: :environment do
        # phone_number = ['+918839390992','+919827157664','+919329385300']
        phone_number = ['+918839390992']
        today = Date.today.strftime("%d-%m-%Y")
        cash_total = Invoice.where(created_at: Time.zone.today.beginning_of_day .. Time.zone.now, payment_mode: 'Cash', notes: "").kept.sum(:total)
        online_total = Invoice.where(created_at: Time.zone.today.beginning_of_day ..Time.zone.now, payment_mode: 'Online', notes: "").kept.sum(:total)
        backdated_inv_count = Invoice.where(created_at: Time.zone.today.beginning_of_day ..Time.zone.now).where.not(notes: "").kept.count
        backdated_inv_sum = Invoice.where(created_at: Time.zone.today.beginning_of_day ..Time.zone.now).where.not(notes: "").kept.sum(:total)
        backdated_inv_notes = Invoice.where(created_at: Time.zone.today.beginning_of_day ..Time.zone.today.end_of_day).where.not(notes: "").kept.pluck(:notes).uniq        
        backdated_notes_invoices = Hash.new(0)
        
        Invoice.where(notes: backdated_inv_notes).each do |inv|             
            backdated_notes_invoices[inv.notes] += 1
        end
        
        total = cash_total + online_total
        
        message = "Total fees for #{today} - #{total}. Cash - #{cash_total} | Online - #{online_total}. #{backdated_inv_count} backdated invoices entered today with total amount - #{backdated_inv_sum} with these stats - \n #{backdated_notes_invoices}."
    
        phone_number.each do |phn|
            Services::SmsService.send_invoice_message(phn, message)
        end
    end
end