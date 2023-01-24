class AddDiscardedAtToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :discarded_at, :datetime
    add_index :invoices, :discarded_at
  end
end
