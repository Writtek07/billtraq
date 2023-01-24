class RenameTaxToTotalInInvoices < ActiveRecord::Migration[6.0]
  def up
      rename_column :invoices, :tax, :total
    end

    def down
      rename_column :invoices, :total, :tax
    end
end
