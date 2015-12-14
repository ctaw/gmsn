class AdditionalTables < ActiveRecord::Migration
  def change
    create_table :penalty_checkers do |t|
      t.string :student_number
      t.integer :due_of_payments_id
      t.string :due_date
      t.decimal :amount
      t.integer :is_paid
    end
  end
end
