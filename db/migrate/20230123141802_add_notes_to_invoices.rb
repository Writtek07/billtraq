class AddNotesToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :notes, :string
  end
end
