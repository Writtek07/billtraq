class AddDateOfAdmissionToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :date_of_admission, :date
  end
end
