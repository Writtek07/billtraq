class AddDiscardedByToParticulars < ActiveRecord::Migration[6.0]
  def change
    add_column :particulars, :discarded_by, :integer
  end
end
