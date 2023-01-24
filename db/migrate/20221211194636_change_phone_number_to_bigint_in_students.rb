class ChangePhoneNumberToBigintInStudents < ActiveRecord::Migration[6.0]
  def up
        change_column :students, :phone_number, :bigint
    end

    def down
        change_column :students, :phone_number, :integer
    end
end
