class ChangeEmailToDobInStudents < ActiveRecord::Migration[6.0]
  def change
    remove_column :students, :email, :string
    add_column :students, :dob, :date
  end
end
