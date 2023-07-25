class AddSmsDetailsToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :sms_status, :integer, default: 0
    add_column :students, :sms_sent_count, :integer, default: 0
    add_column :students, :sent_at, :datetime
    add_column :students, :message, :string
  end
end
