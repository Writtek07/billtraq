json.extract! invoice, :id, :date, :student, :total, :salesperson, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
