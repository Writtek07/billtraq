class AddPaymentModeToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :payment_mode, :string
  end
end
