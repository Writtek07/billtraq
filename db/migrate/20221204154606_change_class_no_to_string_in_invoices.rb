class ChangeClassNoToStringInInvoices < ActiveRecord::Migration[6.0]
  def up
      change_column :invoices, :class_no, :string
  end

  def down
      change_column :invoices, :class_no, :integer
  end
end
