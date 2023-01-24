class AddReceiptNumberToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :receipt_number, :bigint
  end
end
