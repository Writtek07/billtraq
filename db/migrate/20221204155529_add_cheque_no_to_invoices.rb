class AddChequeNoToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :cheque_no, :bigint
  end
end
