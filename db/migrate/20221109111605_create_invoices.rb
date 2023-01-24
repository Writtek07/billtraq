class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.datetime :date
      t.string :student
      t.decimal :tax
      t.string :salesperson

      t.timestamps
    end
  end
end
