class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :admission_no
      t.integer :phone_number
      t.integer :grade
      t.string :section
      t.string :father_name
      t.string :mother_name

      t.timestamps
    end
  end
end
