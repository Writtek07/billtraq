class AddPendingMonthsToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :pending_fees, :json, default: []
    add_column :students, :fee_pending, :boolean, default: false
  end
end
