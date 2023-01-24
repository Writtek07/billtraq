invoices = []
Invoice.find_each do |inv|
	invoices << [inv.id, inv.date, inv.total, inv.user_id, inv.tax, inv.payment_mode, inv.student_id, inv.class_no, inv.cheque_no, inv.receipt_number, inv.bank_account, inv.status, inv.discarded_at, inv.month_from, inv.month_to, inv.discarded_by]
end	

execution_time = Time.zone.now.strftime("%Y_%m_%d_%H_%M_%S")
file = "#{Rails.root}/lib/invoices_record_#{execution_time}.csv"
headers = ["id","date","total","user_id","tax","payment_mode","student_id","class_no","cheque_no","receipt_number","bank_account","status","discarded_at","month_from","month_to","discarded_by"]
CSV.open(file, 'wb', write_headers: true, headers: headers) do |writer|
  invoices.each do |data|
  	writer << data
  end
end


=> Particular(id: integer, fee_type: string, amount: decimal, invoice_id: integer, created_at: datetime, updated_at: datetime, discarded_at: datetime)

part = []
Particular.find_each do |p|
	part << [p.id, p.fee_type, p.amount, p.invoice_id, p.discarded_at]
end	

execution_time = Time.zone.now.strftime("%Y_%m_%d_%H_%M_%S")
file = "#{Rails.root}/lib/particular_record_#{execution_time}.csv"
headers = ["id", "fee_type", "amount", "invoice_id", "discarded_at"]
CSV.open(file, 'wb', write_headers: true, headers: headers) do |writer|
  part.each do |data|
  	writer << data
  end
end


file = "#{Rails.root}/lib/particulars.csv"
CSV.foreach(file, headers: true) {|row| Particular.create! row.to_hash }
