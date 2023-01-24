#all missing invoice_to & _from update to current month

missing_inv_month_ids = []
Invoice.all.each do |inv|
if !inv.month_to.present? || !inv.month_from.present?
    missing_inv_month_ids << inv.id
    inv.update_attributes!(month_from: Date.current.strftime("%Y-%m"), month_to: Date.current.strftime("%Y-%m"))
end
puts missing_inv_month_ids
end

Invoice.where(id: missing_inv_month_ids).each do |inv|
    inv.update_attributes!(month_from: Date.current.strftime("%Y-%m"), month_to: Date.current.strftime("%Y-%m"))
end