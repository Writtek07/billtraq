class AddDiscardedAtToParticular < ActiveRecord::Migration[6.0]
  def change
    add_column :particulars, :discarded_at, :datetime
    add_index :particulars, :discarded_at
  end
end
