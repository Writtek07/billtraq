class RemoveStudentFromInvoices < ActiveRecord::Migration[6.0]
  def change
    remove_column :invoices, :student, :string
    add_column :invoices, :student_id, :integer 
  end
end
