class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :company
      t.decimal :total_amount
      t.date :due_date

      t.timestamps
    end
  end
end
