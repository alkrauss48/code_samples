class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :initials
      t.string :first_name
      t.string :last_name
      t.date :birth_date

      t.timestamps
    end
  end
end
