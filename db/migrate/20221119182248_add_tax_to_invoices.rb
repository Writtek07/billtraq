class AddTaxToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :tax, :decimal
  end
end
