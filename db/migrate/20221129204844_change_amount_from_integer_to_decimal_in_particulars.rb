class ChangeAmountFromIntegerToDecimalInParticulars < ActiveRecord::Migration[6.0]
  def up
      change_column :particulars, :amount, :decimal
    end

    def down
      change_column :particulars, :amount, :integer
    end
end
