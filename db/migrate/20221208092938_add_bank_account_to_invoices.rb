class AddBankAccountToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :bank_account, :string
  end
end
