class AddClassNoToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :class_no, :integer
  end
end
