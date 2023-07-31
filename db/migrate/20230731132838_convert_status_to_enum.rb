class ConvertStatusToEnum < ActiveRecord::Migration[6.0]
  def up
    add_column :invoices, :new_status, :integer, default: 0

    # Map the old string values to their corresponding integer values
    Invoice.reset_column_information
    Invoice.find_each do |invoice|
      invoice.update(new_status: 0) if invoice.status == 'Paid'
      invoice.update(new_status: 1) if invoice.status == 'Pending'
    end

    remove_column :invoices, :status
    rename_column :invoices, :new_status, :status
  end

  def down
    add_column :invoices, :new_status, :string

    # Map the old integer values to their corresponding string values
    Invoice.reset_column_information
    Invoice.find_each do |invoice|
      invoice.update(new_status: 'Paid') if invoice.status == 0
      invoice.update(new_status: 'Pending') if invoice.status == 1
    end

    remove_column :invoices, :status
    rename_column :invoices, :new_status, :status
  end
end
