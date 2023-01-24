class AddStatusToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :status, :string
  end
end
