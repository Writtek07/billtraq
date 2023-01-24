class CreateParticulars < ActiveRecord::Migration[6.0]
  def change
    create_table :particulars do |t|
      t.string :fee_type
      t.integer :amount
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
