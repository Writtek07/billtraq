class ChangeGradeToStringInStudent < ActiveRecord::Migration[6.0]
  def up
      change_column :students, :grade, :string
  end

  def down
      change_column :students, :grade, :integer
  end
end
