class AddMonthsToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :month_from, :string
    add_column :invoices, :month_to, :string
  end
end
