class CreateBreakdowns < ActiveRecord::Migration
  def change
    create_table :breakdowns do |t|
      t.decimal :amount
      t.date :pay_date
      t.boolean :late_payment
      t.boolean :missed_payment
      t.references :member
      t.references :bill

      t.timestamps
    end
    add_index :breakdowns, :member_id
    add_index :breakdowns, :bill_id
  end
end
