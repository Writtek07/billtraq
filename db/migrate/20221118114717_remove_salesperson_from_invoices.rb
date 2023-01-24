class RemoveSalespersonFromInvoices < ActiveRecord::Migration[6.0]
  def change
    remove_column :invoices, :salesperson, :string
    add_column :invoices, :user_id, :integer
  end
end
