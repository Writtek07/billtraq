class ChangePhonenumToBigintInUsers < ActiveRecord::Migration[6.0]
  def up
        change_column :users, :phonenum, :bigint
    end

    def down
        change_column :users, :phonenum, :integer
    end
end
