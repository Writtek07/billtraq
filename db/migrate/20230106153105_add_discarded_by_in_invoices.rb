class AddDiscardedByInInvoices < ActiveRecord::Migration[6.0]
    def change
      add_column :invoices, :discarded_by, :integer
    end
end
