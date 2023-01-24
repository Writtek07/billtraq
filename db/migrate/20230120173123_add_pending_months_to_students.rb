class AddPendingMonthsToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :pending_fees, :jsonb
    add_column :students, :fee_pending, :boolean
  end
end
